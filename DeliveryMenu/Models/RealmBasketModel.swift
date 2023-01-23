//
//  RealmDishModel.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 14.11.22.
//

import Foundation
import RealmSwift

final class RealmBasketModel: Object {
    @objc dynamic var id: String = ""
    
    convenience init(id: String) {
        self.init()
        
        self.id = id
    }
}
