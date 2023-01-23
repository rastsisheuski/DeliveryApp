//
//  DishCollectionViewCell.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 2.11.22.
//

import UIKit
import SDWebImage

// MARK: -
// MARK: - Protocols

protocol DishCollectionViewCellDelegate:AnyObject {
    func addDishToBasket(id: String)
    func removeDishFromBasket(id: String)
}

class DishCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DishCollectionViewCellDelegate?
    
// MARK: -
// MARK: - IBOutlets
        
    @IBOutlet weak var contentViewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
// MARK: -
// MARK: - PrivateMethods
    
    private var selectedDish: DishModel?

// MARK: -
// MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
// MARK: -
// MARK: - Private Methods
    
    private func setupUI() {
        contentViewContainer.layer.cornerRadius = 12
        contentViewContainer.clipsToBounds = true
    }
    
    private func setupButtons(for button: UIButton, isInBasket: Bool) {
        button.isSelected = isInBasket
        button.backgroundColor = button.isSelected ? Colors.General.selectedButton : Colors.General.unSelectedButton
        if button.isSelected {
            button.setTitle("Добавлено", for: .normal)
        } else {
            button.setTitle("Добавить", for: .normal)
        }
    }
    
    private func setupImageView(selectedModel: DishModel) {
        
        APIManager.shared.getImageURL(folderName: selectedModel.pictureFolderName, picName: selectedModel.pictureName) { [weak self] url in
            guard let self else { return }
            self.imageView.sd_setImage(with: url, placeholderImage: Images.defaultDishImage.image)
        }
    }
        
// MARK: -
// MARK: - Public Methods
    
    func set(for selectedModel: DishModel, isInBasket: Bool) {
        self.selectedDish = selectedModel
        let price = selectedModel.price
        titleLabel.text = selectedModel.name
        weightLabel.text = selectedModel.weightOrVolume
        priceLabel.text = "\(price) ₽."
        
        setupImageView(selectedModel: selectedModel)

        setupButtons(for: addButton, isInBasket: isInBasket)
    }
    
// MARK: -
// MARK: - IBActions
    
    @IBAction func didAddButtonTapped(_ sender: UIButton) {
        guard let id = selectedDish?.id else { return }
        sender.isSelected.toggle()
        print("Button Pressed")
        
        if sender.isSelected {
            setupButtons(for: sender, isInBasket: sender.isSelected)
            delegate?.addDishToBasket(id: id)
        } else {
            setupButtons(for: sender, isInBasket: sender.isSelected)
            delegate?.removeDishFromBasket(id: id)
        }
    }
}
