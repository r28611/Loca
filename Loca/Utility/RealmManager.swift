//
//  RealmManager.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 10/06/2022.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    private init?() {
        let configurator = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        guard let realm = try? Realm(configuration: configurator) else { return nil }
        self.realm = realm
        
        print(realm.configuration.fileURL ?? "realm error")
    }
    
    private let realm: Realm
    
    func save<T: Object>(objects: [T]) throws {
        try realm.write {
            let oldValue = realm.objects(T.self)
            realm.delete(oldValue)
            realm.add(objects, update: .all)
        }
    }
    
    func delete<T: Object>(object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll<T: Object>(objects: T) throws {
        try realm.write {
            realm.delete(objects)
        }
    }
    
    func update(complition: () -> Void ) throws {
        try realm.write {
            complition()
        }
    }
    
    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
    
    func getObjects<T: Object>() -> Results<T> {
        return realm.objects(T.self)
    }

}

extension Results {
    func toArray<T: Object>() -> [T] { compactMap { $0 as? T } }
 }
