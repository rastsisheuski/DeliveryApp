//
//  DeliveryMenuMainTabBarContainer.swift
//  DeliveryMenu
//
//  Created by Евгений on 30.12.22.
//

import UIKit

class DeliveryMenuMainTabBarContainer {
    
    func makeMainTabBarController() -> UITabBarController {
        
        let dishesViewController = {
            self.createDishesViewController()
        }
        
        let basketViewController = {
            self.createBasketViewController()
        }
        
        let tabBar = UITabBarController()
        let appearance = UITabBarAppearance()
        tabBar.tabBar.clipsToBounds = true
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundImage = Images.tabBarBackgroundImage.image
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Colors.General.selectedButton]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = Colors.General.selectedButton
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        tabBar.viewControllers = [createDishesViewController(), createBasketViewController()]
        return tabBar
    }
    
    private func createDishesViewController() -> DishesViewController {
        let dishVC = DishesViewController()
        dishVC.tabBarItem = UITabBarItem(title: "Меню", image: Icons.mainIcon.image, tag: 0)
        return dishVC
    }
    
    private func createBasketViewController() -> BasketViewController {
        let basketVC = BasketViewController()
        basketVC.tabBarItem = UITabBarItem(title: "Корзина", image: Icons.basketIcon.image, tag: 1)
        return basketVC
    }
}
