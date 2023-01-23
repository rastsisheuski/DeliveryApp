//
//  Constants.swift
//  DeliveryMenu
//
//  Created by Евгений on 3.12.22.
//

import Foundation

enum Constants {
    enum TabBar {
        static let tbBarHegiht: CGFloat = 83
    }
    
     enum InputView {
         static let textFieldHeight: CGFloat = 50
         static let textFieldFontSize: CGFloat = 15
         static let titleFoncSize: CGFloat = 25
         static let fieldLeftViewWidth: CGFloat = 15
         static let mainButtonsHeight: CGFloat = 70
    }
    
    enum AuthTextField {
        static let textFieldVerticalPadding: CGFloat = 16
        static let textFieldHorizontalPadding: CGFloat = 16
        static let placeholderFontSize: CGFloat = 16
        static let errorLabelFontSize: CGFloat = 10
        static let animationTime: Double = 0.5
    }
    
    enum RegistrationBottomView {
        static let checkBoxHeight: CGFloat = 32
        static let privacyPolicyStringFontSize: CGFloat = 12
        static let confirmButtonVerticalPadding: CGFloat = 20
        static let confirmButtonHorizontalPadding: CGFloat = 20
        static let confirmButtonFontSize: CGFloat = 20
        static let titleFontSize: CGFloat = 25
    }
    
    enum LoginBottomView {
        static let titleFontSize: CGFloat = 25
        static let forgotPasswordFontSize: CGFloat = 10
        static let registrationAccountFontSize: CGFloat = 13
    }
    
    enum TimerInterval {
        static let interval: Double = 1.5
    }
}
