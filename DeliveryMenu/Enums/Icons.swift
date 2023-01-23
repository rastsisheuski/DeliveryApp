//
//  Icons.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 29.11.22.
//

import UIKit

enum Icons {
    case mainIcon
    case basketIcon
    case profileIcon
    case defaultDishIcon
    case totalBasketIcon
    case deliveryBasketIcon
    case ckeckIcon
    
    var image: UIImage {
        switch self {
            case .mainIcon:             return UIImage(named: "mainIcon") ?? UIImage()
            case .basketIcon:           return UIImage(named: "basketIcon") ?? UIImage()
            case .profileIcon:          return UIImage(named: "profileIcon") ?? UIImage()
            case .defaultDishIcon:      return UIImage(named: "defaultDishIcon") ?? UIImage()
            case .totalBasketIcon:      return UIImage(named: "totalBasketIcon") ?? UIImage()
            case .deliveryBasketIcon:   return UIImage(named: "deliveryBasketIcon") ?? UIImage()
            case .ckeckIcon:            return UIImage(named: "ckeckIcon") ?? UIImage()
        }
    }
}


