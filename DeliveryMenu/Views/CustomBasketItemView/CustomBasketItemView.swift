//
//  CustomBasketItemView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 15.11.22.
//

import UIKit

class CustomBasketItemView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    private var selectedModel: DishModel?
    private var counter: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func setupImageView(selectedModel: DishModel) {
        
        APIManager.shared.getImageURL(folderName: selectedModel.pictureFolderName, picName: selectedModel.pictureName) { [weak self] url in
            guard let self else { return }
            self.imageView.sd_setImage(with: url, placeholderImage: Icons.defaultDishIcon.image) 
        }
    }
    
    func commonInit() {
        let id = String(describing: CustomBasketItemView.self)
        Bundle.main.loadNibNamed(id, owner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.layer.cornerRadius = 30
        self.contentView.clipsToBounds = true
    }
    
    func set(selectedModel: DishModel) {
        self.selectedModel = selectedModel
        let price = selectedModel.price
        nameLabel.text = selectedModel.name
        descriptionLabel.text = selectedModel.weightOrVolume
        counterLabel.text = "1"
        amountLabel.text = "\(price) ₽."
        
        setupImageView(selectedModel: selectedModel)
    }
    
    private func countAmount() {
        guard let selectedModel else { return }
        let totalAmount = selectedModel.price * counter
        amountLabel.text = "\(totalAmount) ₽."
    }
    
    @IBAction func didChangeCountButtonTap(_ sender: UIButton) {
        switch sender.tag {
            case 0:
                if counter > 1 {
                    counter -= 1
                    counterLabel.text = "\(counter)"
                    countAmount()
                }
            case 1:
                counter += 1
                counterLabel.text = "\(counter)"
                countAmount()
            default:
                break
        }
    }
}
