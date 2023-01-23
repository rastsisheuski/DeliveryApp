//
//  CheckBoxButton.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 23.12.22.
//

import UIKit

class CheckBoxButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            
        }
    }
    
    let selectedImage: UIImage = Icons.ckeckIcon.image.withRenderingMode(.alwaysTemplate)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupCheckBox()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCheckBox() {
        layer.borderColor = Colors.General.selectedButton.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        tintColor = Colors.General.selectedButton
        setImage(selectedImage, for: .selected)
        setImage(UIImage(), for: .normal)
        contentMode = .scaleAspectFit
        
        addTarget(self, action: #selector(didAddButtonTapped), for: .touchUpInside)
    }
}

extension CheckBoxButton {
    @objc private func didAddButtonTapped() {
        self.isSelected = !self.isSelected
    }
}
