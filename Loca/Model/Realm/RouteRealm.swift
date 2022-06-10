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
    dynamic var startDate = Date()
    dynamic var endDate = Date()
}
