//
//  MainViewModel.swift
//  DeliveryMenu
//
//  Created by Евгений on 30.12.22.
//

import UIKit

class MainViewModel {
    let mainView: Dynamic<MainView?> = Dynamic(nil)
    let stepBack: Dynamic<Void> = Dynamic(Void())
    
    func checkAuthorization() {
        mainView.value = .login
    }
}

extension MainViewModel: MainResponder {
    func mainTabBar() {
        mainView.value = .mainTabBar
    }
    
    func showLogin() {
        mainView.value = .login
    }
    
    func showRegistration() {
        mainView.value = .registration
    }
}

extension MainViewModel: NavigationStepBackResponder {
    func handleStepBack() {
        stepBack.value = Void()
    }
}
