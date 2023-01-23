//
//  SpinerView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 7.11.22.
//

import UIKit

final class SpinnerView {
    
    static let shared = SpinnerView()
    
    private var window: UIWindow!
    
// MARK: -
// MARK: - Public Methods
    
    func createSpiner() {
        //создание вью поверх всех экранов
        let windowScene = UIApplication.shared.connectedScenes.first
        guard let windowScene = windowScene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        let vc = SpinerViewController(nibName: String(describing: SpinerViewController.self), bundle: nil)
        self.window.rootViewController = vc
        self.window.windowLevel = UIWindow.Level.alert + 1
        self.window.makeKeyAndVisible()
    }
    
    func stopSpiner() {
        window = nil
    }
}
