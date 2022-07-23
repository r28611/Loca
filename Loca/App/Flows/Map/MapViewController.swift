//
//  MapViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/05/2022.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    private var router: Router?
    private var mapViewModel: MapViewModel?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewModel = MapViewModelImpl(mapView: mapView)
        mapViewModel?.configureMap()
        router = MapRouter(viewController: self)
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
    
    @IBAction private func authDidTapped(_ sender: UIBarButtonItem) {
        router?.navigateToUserArea()
    }
    
    private func showAlert() {
        
        guard let router = router else { return }
        
        let alert = router.makeAlert(complitionFirstAction: { [weak self] in
            self?.mapViewModel?.saveTrack()
            self?.mapViewModel?.startTracking()
        }, complitionSecondAction: { [weak self] in
            self?.mapViewModel?.startTracking()
        })

        self.present(alert, animated: true, completion: nil) }
}
