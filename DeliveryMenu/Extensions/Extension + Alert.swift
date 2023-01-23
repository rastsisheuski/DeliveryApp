//
//  Extension + Alert.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import UIKit

extension UIViewController {
    func showMessageToUser(title: String, msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


