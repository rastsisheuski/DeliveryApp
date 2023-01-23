//
//  LoginVCСondition.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 12.12.22.
//

import Foundation

enum LoginVCCondition {
    case login
    case registration
    
    var title: String {
        switch self {
            case .login:            return "Войти в аккаунт"
            case .registration:     return "Регистрация"
        }
    }
    
    var isNameFieldEnable: Bool {
        switch self {
            case .login:            return true
            case .registration:     return false
        }
    }
    
    var isEmailFieldEnable: Bool {
        switch self {
            case .login:            return true
            case .registration:     return false
        }
    }
    
    var isForgotPasswordEnable: Bool {
        switch self {
            case .login:            return false
            case .registration:     return true
        }
    }
    
    var isApprovalPrivacyStackEnable: Bool {
        switch self {
            case .login:            return true
            case .registration:     return false
        }
    }
    
    var isConfirmNumberButtonEnable: Bool {
        switch self {
            case .login:            return true
            case .registration:     return false
        }
    }
    
    var isEnterButtonEnable: Bool {
        switch self {
            case .login:            return false
            case .registration:     return true
        }
    }
    
    var isNoAccountStackEnable: Bool {
        switch self {
            case .login:            return false
            case .registration:     return true
        }
    }
    
    var isBackButonEnabled: Bool {
        switch self {
            case .login:            return false
            case .registration:     return true
        }
    }
}

