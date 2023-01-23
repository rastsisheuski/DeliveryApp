//
//  AuthTextFieldView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 26.12.22.
//

import UIKit

class AuthTextFieldView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: Constants.AuthTextField.errorLabelFontSize, weight: .regular)
        label.alpha = 0
        return label
    }()
    
    lazy var textField: AuthTextField = {
        let textField = AuthTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.fieldDelegate = self
        return textField
    }()
    
    // MARK: -
    // MARK: - LifeCycle
     
    init(type: AuthTextField.ValidationType) {
         super .init(frame: .zero)
         
        layoutElements()
        setupTextField(type: type)
        setupErrorLabel(type: type)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func layoutElements() {
        layoutErrorLabel()
        layoutTextField()
    }
    
    private func setupTextField(type: AuthTextField.ValidationType) {
        textField.set(type: type)
    }
    private func setupErrorLabel(type: AuthTextField.ValidationType) {
        errorLabel.text = type.errorText
    }
    
    private func layoutErrorLabel() {
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func layoutTextField() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension AuthTextFieldView: AuthTextFieldDelegate {
    func updateErrorTitleState(withAlpha: CGFloat, type: AuthTextField.ValidationType, errorLabelAlphaComponent: CGFloat) {
        errorLabel.alpha = withAlpha
        errorLabel.textColor = .red.withAlphaComponent(errorLabelAlphaComponent)
        setupErrorLabel(type: type)
        
        layoutIfNeeded()
    }
}
