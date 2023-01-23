//
//  Images.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 7.12.22.
//

import UIKit

enum Images {
    case defaultDishImage
    case tabBarBackgroundImage
    case loginBackgroundImage
    case logoImage
    
    var image: UIImage {
        switch self {
            case .defaultDishImage:         return UIImage(named: "defaultDishImage") ?? UIImage()
            case .tabBarBackgroundImage:    return UIImage(named: "tabBarBackgroundImage") ?? UIImage()
            case .loginBackgroundImage:     return UIImage(named: "loginBackgroundImage") ?? UIImage()
            case .logoImage:                return UIImage(named: "logoImage") ?? UIImage()
        }
    }
}
