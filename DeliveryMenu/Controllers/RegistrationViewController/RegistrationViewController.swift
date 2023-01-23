//
//  RegistrationViewController.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import UIKit

class RegistrationViewController: NiblessViewController {
    
    var contentView: RegistrationViewControllerView {
        view as! RegistrationViewControllerView
    }
    
    let navigationStepBackResponder: NavigationStepBackResponder
    let authService: AuthService
    
    init(authService: AuthService, navigationStepBackResponder: NavigationStepBackResponder) {
        self.authService = authService
        self.navigationStepBackResponder = navigationStepBackResponder
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = RegistrationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setuptargets()
    }
    
    private func setuptargets() {
        contentView.bottomView.registrationButton.addTarget(self, action: #selector(confirmButtonWasPressed), for: .touchUpInside)
        contentView.backButton.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
    }
    
    private func createUserModel() -> UserModel? {
        let nameTextField = contentView.bottomView.nameView.textField
        let phoneTextField = contentView.bottomView.phoneView.textField
        let emailTextField = contentView.bottomView.emailView.textField
        let passwordTextField = contentView.bottomView.passwordView.textField
        
        guard let name = nameTextField.text, nameTextField.isValid,
              let phone = phoneTextField.text, phoneTextField.isValid,
              let email = emailTextField.text, emailTextField.isValid,
              let password = passwordTextField.text, passwordTextField.isValid else { return nil }
        
        let currentUser = UserModel(
            name: name,
            email: email,
            phoneNumber: phone,
            password: password)
        
        return currentUser
    }
}

extension RegistrationViewController {
    @objc private func confirmButtonWasPressed() {
        contentView.bottomView.checkisValidFields()
        
        guard let user = createUserModel() else { return }
        
        authService.createUser(user: user) { result in
            switch result {
                case .success(_):
                    APIManager.shared.setUserData(currentUser: user)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @objc private func backButtonWasPressed() {
        navigationStepBackResponder.handleStepBack()
    }
}
