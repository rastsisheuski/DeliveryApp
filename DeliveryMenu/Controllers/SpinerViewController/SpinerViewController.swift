//
//  SpinerViewController.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 15.11.22.
//

import UIKit

class SpinerViewController: UIViewController {
    
    
    @IBOutlet weak var activiryIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activiryIndicator.startAnimating()
        self.view.backgroundColor = Colors.SpinnerView.mainColorWithAlpha
    }
}
