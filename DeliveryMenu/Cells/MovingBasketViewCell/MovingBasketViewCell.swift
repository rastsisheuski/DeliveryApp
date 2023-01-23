//
//  MovingBasketViewCell.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 5.12.22.
//



// Equatable позволяет сравнивать объекты в методе .containts
// Если у нас будут кастомные классы у пропертей внутри объекта, то метод Equatable нужно будет переобперелять вручную самому

struct MovingBasketViewCellModel: Equatable {
    var image: UIImage
    var title: String
    var amount: Int
}

import UIKit

class MovingBasketViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func set(model: MovingBasketViewCellModel) {
        iconImageView.image = model.image.withRenderingMode(.alwaysTemplate)
        titleLabel.text = model.title
        amountLabel.text = "\(model.amount)  ₽."
    }
    
    private func setupUI() {
        setupLabels()
        setupIconImageView()
    }
    
    private func setupLabels() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        amountLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        titleLabel.textColor = .white
        amountLabel.textColor = .white
        
        titleLabel.textAlignment = .left
        amountLabel.textAlignment = .center
    }
    
    private func setupIconImageView() {
        iconImageView.tintColor = Colors.General.selectedButton
    }
}
