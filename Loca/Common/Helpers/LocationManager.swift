//
//  LocationManager.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 12/07/2022.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    let locationManager = CLLocationManager()
    
    var location: CLLocation? = nil {
        didSet {
            locationChangedHandler?(location)
        }
    }
    
    var locationChangedHandler: ((CLLocation?) -> Void)?
    
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
        
        self.location = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
