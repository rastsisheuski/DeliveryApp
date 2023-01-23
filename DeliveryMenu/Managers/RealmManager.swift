//
//  RealmManager.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 14.11.22.
//

import Foundation
import RealmSwift

class RealmManager<T> where T: Object {
    
    private let realm = try! Realm()
    
// MARK: -
// MARK: - Public Methods

    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func read() -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func delete(object: T) {
        try? realm.write {
            realm.delete(object)
        }
    }
}
