//
//  ViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/05/2022.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    // 'Zhdun' (Homunculus Loxodontus) 52.1662, 4.4784
    private let zhdunCoordinate = CLLocationCoordinate2D(latitude: 52.16767867509046, longitude: 4.478252575153958)
    private var marker: GMSMarker?
    private var geoCoder: CLGeocoder?
    private var locationManager: CLLocationManager?
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var markersQueue = Queue<GMSMarker>(limit: 2)
    private var timer: Timer?
    private var startTime: Date?
    private let timeInterval: TimeInterval = 180
    private var beginBackgroundTask: UIBackgroundTaskIdentifier?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
        configureTimer()
    }
    
    func configureTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            print(Date())
        }
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification, object: nil,
            queue: OperationQueue.main) { [weak self] _ in
                self?.timer?.invalidate()
                self?.timer = nil
            }
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
                self?.configureTimer()
            }
    }
    
    func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: zhdunCoordinate, zoom: 12)
        mapView.camera = camera
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
    }
    
    @IBAction private func goTo(_ sender: UIButton) {
        
        if marker == nil {
            findZhdun()
            addZhdun()
        } else {
            removeMarker()
        }
    }
    
    @IBAction private func routeDidTapped() {
        drawPolyline()
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        
        locationManager?.startUpdatingLocation()
    }
    
    private func findZhdun() {
        mapView.animate(to: GMSCameraPosition(latitude: zhdunCoordinate.latitude,
                                              longitude: zhdunCoordinate.longitude,
                                              zoom: 15))
    }
    
    private func addZhdun() {
        marker = GMSMarker(position: zhdunCoordinate)
        
        marker?.icon = UIImage(named: "zhdun-icon")
        marker?.title = "Homunculus Loxodontus"
        marker?.snippet = "Waiting for you..."
        marker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        
        marker?.map = mapView
    }
    
    func removeMarker() {
        marker?.map = nil
        marker = nil
    }
    
    private func configureLocationManager() {
        if locationManager == nil {
            locationManager = CLLocationManager()
        }
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
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
}

extension ViewController: GMSMapViewDelegate {
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
            print(places?.last)
        })
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        routePath?.add(location.coordinate)
        route?.path = routePath
        
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: position)
        
        print(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
