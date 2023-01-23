//
//  LoginViewModel.swift
//  DeliveryMenu
//
//  Created by Евгений on 30.12.22.
//

import Foundation

class LoginViewModel {

    
    let signInResponce: Dynamic<Error?> = Dynamic(nil)
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn(loginUser: LoginUser) {
        authService.signIn(loginUser: loginUser) { [weak self] result in
            switch result {
                case .success(_):
                    self?.signInResponce.value = nil
// TODO: - делегатом  dismiss экран
                case .failure(let error):
                    self?.signInResponce.value = error
            }
        }
    }
}
