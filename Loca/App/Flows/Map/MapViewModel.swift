//
//  MapViewModel.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 08/06/2022.
//

import Foundation
import GoogleMaps

protocol MapViewModel {
    func handleLocationChanged(location: CLLocation?)
    func configureMap()
    func startTracking()
    func stopTracking()
    func saveTrack()
    func drawPolylineByTappedMarkers()
}

final class MapViewModelImpl: NSObject, MapViewModel {
    let mapView: GMSMapView
    private var geoCoder: CLGeocoder?
    private var markersQueue: Queue<GMSMarker>
    private var routePolyline: GMSPolyline?
    private var routePath: GMSMutablePath?
    
    private let realmManager = RealmManager.shared
    private let locationManager = LocationManager.instance
    
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
    
    func configureLocationManager() {
        locationManager.locationChangedHandler = handleLocationChanged(location:).self
    }
    
    func handleLocationChanged(location: CLLocation?) {
        
        guard let location = location else { return }
        
        routePath?.add(location.coordinate)
        routePolyline?.path = routePath
        
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: position)
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
        
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
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

extension MapViewModelImpl: GMSMapViewDelegate {
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
            
            let locationRealm: Location = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            try? self.realmManager?.save(objects: [locationRealm])
        })
    }
}
