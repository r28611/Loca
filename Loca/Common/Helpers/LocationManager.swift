//
//  LocationManager.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 11/07/2022.
//

import Foundation
import CoreLocation
import RxSwift

final class LocationManager: NSObject {
    
    static let instance = LocationManager()

    private override init() {
        super.init()
        configureLocationManager()
    }
    
    let locationManager = CLLocationManager()
    
    let location: BehaviorSubject<CLLocation?> = BehaviorSubject<CLLocation?>(value: nil)
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager() {

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        self.location.onNext(location)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
