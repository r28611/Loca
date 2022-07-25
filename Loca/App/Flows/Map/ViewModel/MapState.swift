//
//  MapState.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 23/07/2022.
//

import Foundation

protocol MapState {
    func startTracking(viewModel: MapViewModel)
    func stopTracking(viewModel: MapViewModel)
    func saveRoute(viewModel: MapViewModel)
}

class TrackingStarted: MapState {
    func startTracking(viewModel: MapViewModel) {
        
    }
    
    func stopTracking(viewModel: MapViewModel) {
        viewModel.stopTracking()
    }
    
    func saveRoute(viewModel: MapViewModel) {
        viewModel.stopTracking()
        viewModel.saveTrack()
    }
    
}

class TrackingFinished: MapState {
    func startTracking(viewModel: MapViewModel) {
        //set alert messages and actions
    }
    
    func stopTracking(viewModel: MapViewModel) {
        print("Already stopped")
    }
    
    func saveRoute(viewModel: MapViewModel) {
        viewModel.saveTrack()
    }
    
}

class InitialState: MapState {
    func startTracking(viewModel: MapViewModel) {
        viewModel.startTracking()
    }
    
    func stopTracking(viewModel: MapViewModel) {
        print("Nothing to stop")
    }
    
    func saveRoute(viewModel: MapViewModel) {
        print("Nothing to save")
    }
    
}
