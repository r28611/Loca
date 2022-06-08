//
//  ViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/05/2022.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var beginBackgroundTask: UIBackgroundTaskIdentifier?
    private var mapViewModel: MapViewModel?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewModel = MapViewModel(mapView: mapView)
        mapViewModel?.configureMap()
    }
    
    @IBAction private func getRouteDidTapped() {
        mapViewModel?.drawPolyline()
    }
    
    @IBAction private func updateLocation(_ sender: UIBarButtonItem) {
        mapViewModel?.updateLocation()
    }
    
}
