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
    private var state: MapState = InitialState()
    
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mapView
        
        mapViewModel = MapViewModelImpl(mapView: mapView)
        mapViewModel?.configureMap()
        router = MapRouter(viewController: self)
    }
    
    private func getRouteDidTapped() {
        mapViewModel?.drawPolylineByTappedMarkers()
    }
    
    func startTrackDidTapped() {
        guard let viewModel = mapViewModel else { return }
        state.startTracking(viewModel: viewModel)
        set(state: TrackingStarted())
    }
    
    private func stopTrackDidTapped(_ sender: UIBarButtonItem) {
        guard let viewModel = mapViewModel else { return }
        state.stopTracking(viewModel: viewModel)
        set(state: TrackingFinished())
    }
    
    private func saveTrackDidTapped(_ sender: UIBarButtonItem) {
        guard let viewModel = mapViewModel else { return }
        state.saveRoute(viewModel: viewModel)
        set(state: InitialState())
    }
    
    private func authDidTapped(_ sender: UIBarButtonItem) {
        router?.navigateToUserArea()
    }
    
    private func set(state: MapState) {
        self.state = state
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
