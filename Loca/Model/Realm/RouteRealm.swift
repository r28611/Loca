//
//  RouteRealm.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 10/06/2022.
//

import Foundation
import RealmSwift

class Route: Object {
    var coordinates = List<Location>()
    @objc dynamic var startDate: Date? = Date()
    @objc dynamic var endDate = Date()
    @objc dynamic var id = ""
    
    override init() {}
    
    required init(startDate: Date? = nil, endDate: Date,coordinates: [Location] ) {
        super.init()
        self.startDate = startDate
        self.endDate = endDate
        self.id = DateFormatter().string(from: endDate)
        coordinates.forEach {
            self.coordinates.append($0)
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
