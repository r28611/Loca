//
//  MapViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/05/2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    private var beginBackgroundTask: UIBackgroundTaskIdentifier?
    private var mapViewModel: MapViewModel?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewModel = MapViewModel(mapView: mapView)
        mapViewModel?.configureMap()
    }
    
    @IBAction private func getRouteDidTapped() {
        mapViewModel?.drawPolylineByTappedMarkers()
    }
    
    @IBAction private func startTrackDidTapped(_ sender: UIBarButtonItem) {
        showAlert()
        mapViewModel?.startTracking()
    }
    
    @IBAction private func stopTrackDidTapped(_ sender: UIBarButtonItem) {
        mapViewModel?.stopTracking()
    }
    
    @IBAction private func saveTrackDidTapped(_ sender: UIBarButtonItem) {
        mapViewModel?.saveTrack()
    }
    
    private func showAlert() {
        
        let alertController = UIAlertController(title: "Start a new track",
                                                message: "Do you want to start a new track and save the current one?",
                                                preferredStyle: .alert)
        let createButton = UIAlertAction(title: "Save and start", style: .default) { [weak self] _ in
            self?.mapViewModel?.saveTrack()
            self?.mapViewModel?.startTracking()
        }
        
        let cancelButton = UIAlertAction(title: "Start without saving", style: .destructive) { [weak self] _ in
            self?.mapViewModel?.startTracking()
        }
        
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil) }
}
