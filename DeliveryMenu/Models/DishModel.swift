//
//  DishModel.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.11.22.
//

import UIKit

struct DishModel {
    var name: String
    var type: TypeOfDishesEnum
    var weightOrVolume: String
    var price: Int
    var pictureFolderName: String
    var pictureName: String
    var id: String
    
    init(name: String, type: TypeOfDishesEnum, weightOrVolume: String, price: Int, pictureFolderName: String, pictureName: String, id: String) {
        self.name = name
        self.type = type
        self.weightOrVolume = weightOrVolume
        self.price = price
        self.pictureName = pictureName
        self.pictureFolderName = pictureFolderName
        self.id = id
    }
}
