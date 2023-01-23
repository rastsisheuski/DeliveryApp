//
//  ConfirmRegistrationButton.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 25.12.22.
//

import UIKit

class ConfirmRegistrationButton: UIButton {
    
    // MARK: -
    // MARK: - Private Properties
    
    private let padding = UIEdgeInsets(
        top: Constants.RegistrationBottomView.confirmButtonVerticalPadding,
        left: Constants.RegistrationBottomView.confirmButtonHorizontalPadding,
        bottom: Constants.RegistrationBottomView.confirmButtonVerticalPadding,
        right: Constants.RegistrationBottomView.confirmButtonHorizontalPadding
    )
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(title: String) {
        super .init(frame: .zero)
        
        setupConfirmButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Override Methods
    
//    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
//        return contentRect.inset(by: padding)
//    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupConfirmButton(title: String) {
        contentEdgeInsets = padding
        backgroundColor = Colors.RegistrationBottomView.confirmButtonTextColor
        layer.cornerRadius = 16
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.RegistrationBottomView.confirmButtonFontSize, weight: .regular)
        titleLabel?.textAlignment = .center
    }
    
}
