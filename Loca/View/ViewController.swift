//
//  ViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/05/2022.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
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
    
    @IBAction private func startTrackDidTapped(_ sender: UIBarButtonItem) {
        mapViewModel?.startTracking()
    }
    
    @IBAction private func stopTrackDidTapped(_ sender: UIBarButtonItem) {
        mapViewModel?.stopTracking()
    }
    
    @IBAction private func saveTrackDidTapped(_ sender: UIBarButtonItem) {
        mapViewModel?.saveTrack()
    }
}
