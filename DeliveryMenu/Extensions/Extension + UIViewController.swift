//
//  Extension + UIViewController.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 26.12.22.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func addFullScreen(childViewController child: UIViewController) {
        guard child.parent == nil else {
            return
        }
        
        addChild(child)
        view.addSubview(child.view)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: child.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
        ]
        constraints.forEach { $0.isActive = true }
        view.addConstraints(constraints)
        
        child.didMove(toParent: self)
    }
    
    public func remove(childViewController child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        guard child.parent != nil else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
