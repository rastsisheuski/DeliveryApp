//
//  TypeOfDishesEnum.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.11.22.
//

import UIKit

enum TypeOfDishesEnum: String, CaseIterable {
    case kishes = "kishes"
    case soups = "soups"
    case burgers = "burgers"
    case desserts = "desserts"
    case sauces = "sauces"
    case drinks = "drinks"
    
    var russianTranslate: String {
        switch self {
            case .kishes:   return "Киши"
            case .soups:    return "Супы"
            case .burgers:  return "Бургеры"
            case .desserts: return "Десерты"
            case .sauces:   return "Соусы"
            case .drinks:   return "Напитки"
        }
    }
}
