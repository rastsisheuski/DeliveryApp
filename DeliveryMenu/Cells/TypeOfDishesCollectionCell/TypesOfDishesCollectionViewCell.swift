//
//  TypesOfDishesCollectionViewCell.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.11.22.

import UIKit

class TypesOfDishesCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: TypesOfDishesCollectionViewCell.self)
    
// MARK: -
// MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dishesTypeLabel: UILabel!
    
// MARK: -
// MARK: - Private Properties
    
    private var typeOfDishes: TypeOfDishesEnum = .kishes
    
// MARK: -
// MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.contentView.layer.cornerRadius = 12
        self.contentView.clipsToBounds = true
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
    }
    
// MARK: -
// MARK: - Public Methods
    
    func setupViewWith(typeOfDishes: TypeOfDishesEnum) {
        self.typeOfDishes = typeOfDishes
        containerView.backgroundColor = self.isSelected ? Colors.TypeOfDish.selectedTypeOfDish : Colors.TypeOfDish.unselectedTypeOfDish
        dishesTypeLabel.text = typeOfDishes.russianTranslate
    }
}
