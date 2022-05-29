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
    private let zhdunCoordinate = CLLocationCoordinate2D(latitude: 52.1662, longitude: 4.4784)
    private var marker: GMSMarker?
    
    @IBOutlet private var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                                              zoom: 10))
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
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
    }
}
