//
//  Extension + String.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import Foundation

extension String {
    func isValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        
        return result
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*#?&])[a-zA-Z\\d]{8,16}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: self)
        
        return result
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegEx = "^+375 ((17|29|33|44)) [0-9]{3}-[0-9]{2}-[0-9]{2}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let result = phoneTest.evaluate(with: self)
        
        return result
    }
    
    func isValidName() -> Bool {
        let nameRegEx = "[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let result = test.evaluate(with: self)
        
        return result
    }
}
