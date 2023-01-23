//
//  RegistrationBottomView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import UIKit

class RegistrationBottomView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        // эти функции позволяют выходить за safeArea
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        label.font = UIFont.systemFont(ofSize: Constants.RegistrationBottomView.titleFontSize, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    let nameView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .name)
        view.textField.keyboardType = .namePhonePad
        view.textField.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .email)
        view.textField.keyboardType = .emailAddress
        view.textField.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .password)
        view.textField.keyboardType = .namePhonePad
        view.textField.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .phone)
        view.textField.keyboardType = .phonePad
        view.textField.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let checkBoxButton: CheckBoxButton = {
        let button = CheckBoxButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return   button
    }()
    
    let privacyPolicyString: AttributedStringWithLink = {
        let textView = AttributedStringWithLink(contentText: "Согласен с Политикой конфиденциальности", linkWord: "Политикой конфиденциальности")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: Constants.RegistrationBottomView.privacyPolicyStringFontSize, weight: .regular)
        return textView
    }()
    
    let registrationButton: ConfirmRegistrationButton = {
        let button = ConfirmRegistrationButton(title: "Зарегистрироваться")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            setupView()
            layoutElements()
            firstAppear = false
        }
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func checkisValidFields() {
        nameView.textField.checkValidStateOfTextField()
        emailView.textField.checkValidStateOfTextField()
        passwordView.textField.checkValidStateOfTextField()
        phoneView.textField.checkValidStateOfTextField()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupView() {
        setGradientBackground()
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutTitleLabel()
        layoutStackView()
        layoutCheckBoxButton()
        layoutPrivacyPolicyString()
        layoutConfirmButton()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        scrollView.fillSuperview()
    }
    
    private func layoutTitleLabel() {
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutStackView() {
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(phoneView)
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func layoutCheckBoxButton() {
        scrollView.addSubview(checkBoxButton)
        
        NSLayoutConstraint.activate([
            checkBoxButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            checkBoxButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            checkBoxButton.heightAnchor.constraint(equalToConstant: Constants.RegistrationBottomView.checkBoxHeight),
            checkBoxButton.widthAnchor.constraint(equalTo: checkBoxButton.heightAnchor, multiplier: 1)
        ])
    }
    
    private func layoutPrivacyPolicyString() {
        scrollView.addSubview(privacyPolicyString)

        NSLayoutConstraint.activate([
            privacyPolicyString.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor),
            privacyPolicyString.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 16),
            privacyPolicyString.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutConfirmButton() {
        scrollView.addSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: checkBoxButton.bottomAnchor, constant: 16),
            registrationButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            registrationButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -safeAreaInsets.bottom)
        ])
    }
}
