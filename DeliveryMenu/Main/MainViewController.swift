//
//  MainViewController.swift
//  DeliveryMenu
//
//  Created by Евгений on 30.12.22.
//

import UIKit

class MainViewController: NiblessViewController {
    
    let viewModel: MainViewModel
    
    let loginViewControllerFactory: () -> LoginViewController
    let registrationViewControllerFactory: () -> RegistrationViewController
    let mainTabBarControllerFactory: () -> UITabBarController
    
    private let currentNavigationController = UINavigationController()
    
    init(viewModel: MainViewModel,
         loginViewControllerFactory: @escaping () -> LoginViewController,
         registrationViewControllerFactory: @escaping () -> RegistrationViewController,
         mainTabBarControllerFactory: @escaping () -> UITabBarController) {
        self.viewModel = viewModel
        self.loginViewControllerFactory = loginViewControllerFactory
        self.registrationViewControllerFactory = registrationViewControllerFactory
        self.mainTabBarControllerFactory = mainTabBarControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentNavigationController.navigationBar.isHidden = true
        bindViewModel()
        
        viewModel.checkAuthorization()
    }
    
    private func bindViewModel() {
        viewModel.mainView.bind { [weak self] mainView in
            guard let mainView,
                  let self else { return }
            switch mainView {
            case .login:
                self.presentLoginViewController()
            case .registration:
                self.presentRegistrationViewController()
            case .mainTabBar:
                self.presentMainTabBar()
            }
        }
        
        viewModel.stepBack.bind { [weak self] _ in
            self?.currentNavigationController.popViewController(animated: true)
        }
    }
    
    private func presentLoginViewController() {
        let loginVC = loginViewControllerFactory()
        addFullScreen(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = [loginVC]
    }
    
    private func presentRegistrationViewController() {
        let registrationVC = registrationViewControllerFactory()
        currentNavigationController.pushViewController(registrationVC, animated: true)
    }
    
    private func presentMainTabBar() {
        remove(childViewController: currentNavigationController)
        let mainTabBar = mainTabBarControllerFactory()
        addFullScreen(childViewController: mainTabBar)
    }
}
