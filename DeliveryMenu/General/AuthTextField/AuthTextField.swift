//
//  AuthTextField.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

protocol AuthTextFieldDelegate: AnyObject {
    func updateErrorTitleState(withAlpha: CGFloat, type: AuthTextField.ValidationType, errorLabelAlphaComponent: CGFloat)
}

import UIKit

class AuthTextField: UITextField {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var type = ValidationType.none
    private var errorTitle: String?
    private var timer: Timer?
    private var placeholderText = ""
    
    private let padding = UIEdgeInsets(
        top: Constants.AuthTextField.textFieldVerticalPadding,
        left: Constants.AuthTextField.textFieldHorizontalPadding,
        bottom: Constants.AuthTextField.textFieldVerticalPadding,
        right: Constants.AuthTextField.textFieldHorizontalPadding
    )
    
    // MARK: -
    // MARK: - Public Properties
    
    weak var fieldDelegate: AuthTextFieldDelegate?
    
    var isValid: Bool {
        let result = validate(string: self.text, pattern: self.type)
        return result
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Override Methods
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    func set(type: ValidationType) {
        self.type = type
        self.placeholderText = type.placeholderText
        self.errorTitle = type.errorText
        
        setupAtributtedPlaceholder()
    }
    
    func checkValidStateOfTextField() {
        isValid ? setValidState() : setInvalidateState()
    }
    
    private func setupAtributtedPlaceholder() {
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.General.placeholderText,
                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.AuthTextField.placeholderFontSize)
        ]
        let attributedPlaceholderString = NSAttributedString(string: placeholderText, attributes: attributes)
        attributedPlaceholder = attributedPlaceholderString
        
        addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupPlaceholder() {
        backgroundColor = Colors.General.placeholderBackground
        layer.cornerRadius = 12
        clipsToBounds = true
        textColor = .white
    }
    
    private func validate(string: String?, pattern: ValidationType) -> Bool {
        if pattern == .none {
            return true
        }
        
        guard let string else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern.rawValue)
        
        return predicate.evaluate(with: string)
    }
}

extension AuthTextField {
    @objc private func textFieldDidChange(sender: UITextField) {
        guard let text = sender.text,
              !text.isEmpty
        else { return }
        
        timer?.invalidate()
        timer = nil
        
        timer = Timer.scheduledTimer(withTimeInterval: Constants.TimerInterval.interval, repeats: false, block: { [weak self] _ in
            guard let self else { return }
            
            if self.validate(string: sender.text, pattern: self.type) {
                self.setValidState()
            } else {
                self.setInvalidateState()
            }
        })
    }
    
    private func setValidState() {
        UIView.animate(withDuration: Constants.AuthTextField.animationTime) { [weak self] in
            guard let self else { return }
            self.fieldDelegate?.updateErrorTitleState(withAlpha: 0, type: self.type, errorLabelAlphaComponent: 1)
            self.layer.borderColor = UIColor.systemGreen.cgColor
        } completion: { [weak self] _ in
            UIView.animate(withDuration: Constants.AuthTextField.animationTime) { [weak self] in
                guard let self else { return }
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    private func setInvalidateState() {
        UIView.animate(withDuration: Constants.AuthTextField.animationTime) { [weak self] in
            guard let self else { return }
            self.fieldDelegate?.updateErrorTitleState(withAlpha: 1, type: self.type, errorLabelAlphaComponent: 1)
            self.layer.borderColor = UIColor.red.cgColor
        } completion: { [weak self] _ in
            UIView.animate(withDuration: Constants.AuthTextField.animationTime) { [weak self] in
                guard let self else { return }
                self.fieldDelegate?.updateErrorTitleState(withAlpha: 1, type: self.type, errorLabelAlphaComponent: 0.7)
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}

extension AuthTextField {
    
    enum ValidationType: String {
        case phone = "(\\+375|375)(29|25|44|33)(\\d{3})(\\d{2})(\\d{2})"
        case email = "[A-z0-9_.+-]+@[A-z0-9-]+(\\.[A-z0-9-]{2,})"
        case name = "[\\S]{2,16}"
        case password = "[\\S]{8,25}"
        case none = "[\\S]"
        
        var placeholderText: String {
            switch self {
                case .phone:
                    return "Введите Ваш телефон"
                case .email:
                    return "Введите Ваш email"
                case .name:
                    return "Введите Ваше имя"
                case .password:
                    return "Введите Ваш пароль"
                case .none:
                    return ""
            }
        }
        
        var errorText: String {
            switch self {
                case .phone:
                    return "Некорректный номер телефона"
                case .email:
                    return "Некорректный email"
                case .name:
                    return "Неправильное имя пользователя"
                case .password:
                    return "Некорректный пароль"
                case .none:
                    return ""
            }
        }
    }
}
