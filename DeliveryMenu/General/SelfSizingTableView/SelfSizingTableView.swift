//
//  SelfSizingTableView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 5.12.22.
//

import UIKit

final class SelfSizingTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            layoutIfNeeded()
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
