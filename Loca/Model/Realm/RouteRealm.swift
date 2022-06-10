//
//  RouteRealm.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 10/06/2022.
//

import Foundation
import RealmSwift

class Route: Object {
    let coordinates = List<Location>()
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
}
