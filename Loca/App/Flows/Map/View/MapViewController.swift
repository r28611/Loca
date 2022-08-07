//
//  MapViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/05/2022.
//

import UIKit
import GoogleMaps

class MapViewController: UITabBarController {
    
    private var router: Router?
    private var mapViewModel: MapViewModel?

    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mapView
        
        mapViewModel = MapViewModelImpl(mapView: mapView)
        mapViewModel?.configureMap()
        router = MapRouter(viewController: self)
    }
    
    func startDidTapped() {
        mapViewModel?.startTracking()
    }
    
    func stopDidTapped() {
        mapViewModel?.stopTracking()
    }
    
    func saveDidTapped() {
        mapViewModel?.saveTrack()
    }
    
    private func authDidTapped(_ sender: UIBarButtonItem) {
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
