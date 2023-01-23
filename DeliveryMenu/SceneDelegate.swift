//
//  SceneDelegate.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 31.10.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let appContainer = DeliveryMenuDepentencyContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootViewController = appContainer.makeMainViewController()
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
//        window?.rootViewController = createTabBar()
//        window?.rootViewController = setupLoginVCAsInitial()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func createTabBar() -> UITabBarController {
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
        tabBar.viewControllers = [setupFirstItem(), setupSecondItem()]
        
        return tabBar
    }
    
    func setupFirstItem() -> UINavigationController {
        let navVC = UINavigationController()
        navVC.navigationBar.isHidden = true
        let mainVC = DishesViewController(nibName: DishesViewController.id, bundle: nil)
        mainVC.tabBarItem = UITabBarItem(title: "Меню", image: Icons.mainIcon.image, tag: 0)
        navVC.viewControllers = [mainVC]
        return navVC
    }
    
    func setupSecondItem() -> BasketViewController {
        let basketVC = BasketViewController(nibName: BasketViewController.id, bundle: nil)
        basketVC.tabBarItem = UITabBarItem(title: "Корзина", image: Icons.basketIcon.image, tag: 1)
        return basketVC
    }
    
//    func setupRegistrationVCAsInitial() -> RegistrationViewController {
//        let registrationVC = RegistrationViewController()
//        return registrationVC
//    }
    
//    func setupLoginVCAsInitial() -> LoginViewController {
//        let loginVC = LoginViewController()
//        return loginVC
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

