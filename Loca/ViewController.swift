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
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
    
    func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: zhdunCoordinate, zoom: 12)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        mapView.delegate = self
    }
    
    @IBAction private func goTo(_ sender: UIButton) {
        
        if marker == nil {
            findZhdun()
            addZhdun()
        } else {
            removeMarker()
        }
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
        
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        
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
    
}
