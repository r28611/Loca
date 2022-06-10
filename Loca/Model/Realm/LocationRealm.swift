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
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}
