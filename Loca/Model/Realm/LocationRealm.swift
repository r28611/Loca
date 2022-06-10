//
//  LocationRealm.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 10/06/2022.
//

import Foundation
import RealmSwift
import GoogleMaps

class Location: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var id = ""

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
    
    override init() {}
    
    required init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.id = String.init(latitude) + String.init(longitude)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
