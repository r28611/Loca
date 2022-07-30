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
    private var currentState: (MapState, TrackState) = (.mapOpened, .saved) {
        didSet {
            guard let tabBar = tabBarController?.tabBar as? CustomTabBar else { return }
            tabBar.setTabBarState(state: currentState)
        }
    }

    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mapView
        
        mapViewModel = MapViewModelImpl(mapView: mapView)
        mapViewModel?.configureMap()
        router = MapRouter(viewController: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentState = (.mapClosed, currentState.1)
    }
    
    func mapButtonDidTapped() {
        guard let viewModel = mapViewModel else { return }
        
        switch currentState.1 {
        case .saved:
            viewModel.startTracking()
            set(state: .tracking)
        case .tracking:
            viewModel.stopTracking()
            set(state: .stoppedTracking)
        case .stoppedTracking:
            viewModel.saveTrack()
            set(state: .saved)
        }
    }
    
    private func authDidTapped(_ sender: UIBarButtonItem) {
        router?.navigateToUserArea()
    }
    
    private func set(state: TrackState) {
        self.currentState.1 = state
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
