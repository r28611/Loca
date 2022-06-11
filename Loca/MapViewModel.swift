//
//  MapViewModel.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 08/06/2022.
//

import Foundation
import GoogleMaps

final class MapViewModel: NSObject {
    let mapView: GMSMapView
    private var geoCoder: CLGeocoder?
    private var locationManager: CLLocationManager?
    private var markersQueue: Queue<GMSMarker>
    private var routePolyline: GMSPolyline?
    private var routePath: GMSMutablePath?
    
    private let realmManager = RealmManager.shared
    
    init(mapView: GMSMapView) {
        self.mapView = mapView
        markersQueue = Queue<GMSMarker>(limit: 2)
    }
    
    func configureMap() {
        
        mapView.isMyLocationEnabled = true
        
        mapView.delegate = self
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func drawPolylineByTappedMarkers() {
        
        guard markersQueue.isFull else { return }
        let coordinates = markersQueue.elements.map({$0.position})
        
        let chunkSize = 3
        let chunkedCoordinates = coordinates.chunked(into: chunkSize)
        
        let path = GMSMutablePath()
        
        for chunk in chunkedCoordinates {
            for coordinate in chunk {
                path.add(coordinate)
            }
            
            if chunk.count == 3 {
                let location1 = CLLocation(latitude: chunk[1].latitude, longitude: chunk[1].longitude)
                let location2 = CLLocation(latitude: chunk[2].latitude, longitude: chunk[2].longitude)
                
                if !GMSGeometryIsLocationOnPath(chunk[1], path, false) ||
                    !GMSGeometryIsLocationOnPath(chunk[2], path, false) ||
                    location2.distance(from: location1) < 1.5 {
                    continue
                }
            }
        }
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = UIColor.orange
        polyline.strokeWidth = 5.0
        polyline.map = self.mapView
        
        let bounds = GMSCoordinateBounds(path: path)
        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 150.0))
    }
    
    func startTracking() {
        
        routePath = GMSMutablePath()
        
        cleanExistingRoutePolyline()
        
        routePolyline = GMSPolyline()
        routePolyline?.map = mapView
        
        locationManager?.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager?.stopUpdatingLocation()
        routePath = nil
    }
    
    func saveTrack() {
        guard let path = routePath else { return }
        
        var coordinates = [Location]()
        for i in 0..<path.count() {
            coordinates.append(Location(from: path.coordinate(at: i)))
        }
        
        let routeRealm = Route(endDate: Date(), coordinates: coordinates)
        try? realmManager?.save(objects: [routeRealm])
        
        cleanExistingRoutePolyline()
    }
    
    private func cleanExistingRoutePolyline() {
        guard let route = routePolyline else { return }
        route.map = nil
        self.routePolyline = nil
    }
}

extension MapViewModel: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        
        if markersQueue.isFull {
            markersQueue.dequeue()?.map = nil
        }
        markersQueue.enqueue(marker)
        
        if geoCoder == nil {
            geoCoder = CLGeocoder()
        }
        
        geoCoder?.reverseGeocodeLocation(.init(latitude: coordinate.latitude, longitude: coordinate.longitude),
                                         completionHandler: { places, error in
            guard let location = places?.last?.location else { return }
            
            print(location)
            
            let locationRealm: Location = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
            try? self.realmManager?.save(objects: [locationRealm])
        })
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        routePath?.add(location.coordinate)
        routePolyline?.path = routePath
        
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: position)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
