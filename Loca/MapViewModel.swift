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
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    
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
    
    func drawPolyline() {
        
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
    
    func updateLocation() {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        
        locationManager?.startUpdatingLocation()
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
        
//        geoCoder?.reverseGeocodeLocation(.init(latitude: coordinate.latitude, longitude: coordinate.longitude),
//                                         completionHandler: { places, error in
//            print(places?.last)
//        })
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        routePath?.add(location.coordinate)
        route?.path = routePath
        
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: position)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}