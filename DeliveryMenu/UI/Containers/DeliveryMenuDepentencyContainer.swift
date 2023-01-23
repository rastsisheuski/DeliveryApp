//
//  DeliveryMenuDepentencyContainer.swift
//  DeliveryMenu
//
//  Created by Евгений on 30.12.22.
//

import UIKit

class DeliveryMenuDepentencyContainer {
    
    func makeMainViewController() -> MainViewController {
        
        let sharedViewModel = createMainViewModel()
        let sharedAuthSetvice = createAuthService()
        
        let loginViewControllerFactory = {
            self.makeLoginViewController(navigationRespnoder: sharedViewModel, authService: sharedAuthSetvice)
        }
        
        let registrationViewControllerFactory = {
            self.makeRegistrationViewController(authService: sharedAuthSetvice, navigationStepBackResponder: sharedViewModel)
        }
        
        let mainTabBarControllerFactory = {
            self.makeMainTabBarControllerFactory()
        }
        
        return MainViewController(viewModel: sharedViewModel, loginViewControllerFactory: loginViewControllerFactory, registrationViewControllerFactory: registrationViewControllerFactory, mainTabBarControllerFactory: mainTabBarControllerFactory)
    }
    
    private func makeLoginViewController(navigationRespnoder: MainResponder, authService: AuthService) -> LoginViewController {
        let viewModel = makeLoginViewModel(authService: authService)
        return LoginViewController(viewModel: viewModel, navigationResponer: navigationRespnoder)
    }
    
    private func makeLoginViewModel(authService: AuthService) -> LoginViewModel {
        return LoginViewModel(authService: authService)
    }
    
    private func makeRegistrationViewController(authService: AuthService, navigationStepBackResponder: NavigationStepBackResponder) -> RegistrationViewController {
        return RegistrationViewController(authService: authService, navigationStepBackResponder: navigationStepBackResponder)
    }
    
    private func makeMainTabBarControllerFactory() -> UITabBarController {
        DeliveryMenuMainTabBarContainer().makeMainTabBarController()
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
    
    private func createAuthService() -> AuthService {
        return AuthService()
    }
}
