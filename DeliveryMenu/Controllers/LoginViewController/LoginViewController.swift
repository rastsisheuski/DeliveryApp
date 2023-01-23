//
//  LoginViewController.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 25.12.22.
//

import UIKit

struct LoginUser {
    var email: String
    var password: String
}

class LoginViewController: NiblessViewController {
    
    let viewModel: LoginViewModel
    let navigationResponer: MainResponder
    
    var contentView: LoginViewControllerView {
        view as!  LoginViewControllerView
    }
    
    init(viewModel: LoginViewModel, navigationResponer: MainResponder) {
        self.viewModel = viewModel
        self.navigationResponer = navigationResponer
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = LoginViewControllerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setupTargets()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.signInResponce.bind { [weak self] error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            self?.navigationResponer.mainTabBar()
        }
    }
    
    private func setupTargets() {
        contentView.bottomView.enterButton.addTarget(self, action: #selector(wasEnterButtonTapped), for: .touchUpInside)
        contentView.bottomView.registrationButton.addTarget(self, action: #selector(registrationButtonWasPressed), for: .touchUpInside)
    }
    
    private func createLoginUser() -> LoginUser? {
        let emailField = contentView.bottomView.emailView.textField
        let passwordField = contentView.bottomView.passwordView.textField
        
        guard let email = emailField.text, emailField.isValid,
              let password = passwordField.text, passwordField.isValid else { return nil }
        
        let loginUser = LoginUser(email: email, password: password)
        return loginUser
    }
}

extension LoginViewController {
    @objc private func wasEnterButtonTapped() {
        contentView.bottomView.checkValidateState()
        guard let loginUser = createLoginUser() else { return }
        viewModel.signIn(loginUser: loginUser)
    }
    
    @objc private func registrationButtonWasPressed() {
        navigationResponer.showRegistration()
    }
}
