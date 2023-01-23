//
//  Extension + Optional.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import Foundation

extension Optional where Wrapped == String {
    
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
