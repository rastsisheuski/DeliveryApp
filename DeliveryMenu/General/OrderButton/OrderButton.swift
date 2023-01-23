//
//  OrderButton.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.12.22.
//


import UIKit

// MARK: -
// MARK: - Struct OrderButtonModel

struct OrderButtonModel {
    var order: String
    var time: String
    var amount: String
}

class OrderButton: UIButton {
    
// MARK: -
// MARK: - Public Properties
    
    override var isHighlighted: Bool {
        didSet {
            let higlightedAlpaValue = 0.8
            let defaultAlphaValue = 1.0
            let alphaComponent = isHighlighted ? higlightedAlpaValue : defaultAlphaValue
            orderLabel.textColor = .black.withAlphaComponent(alphaComponent)
            backgroundColor = Colors.General.selectedButton.withAlphaComponent(alphaComponent)
        }
    }
    
    var orderLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    var timeDeliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = Colors.OrderButton.backgroundLabelOrderButton
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = Colors.OrderButton.backgroundLabelOrderButton
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
// MARK: -
// MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupOrderButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupOrderButton()
    }
    
// MARK: -
// MARK: - Public Methods
    
    func setupButtonLabels(model: OrderButtonModel) {
        self.amountLabel.text = model.amount
        self.orderLabel.text = model.order
        self.timeDeliveryLabel.text = model.time
    }

// MARK: -
// MARK: - Private Methods
    
    func setupOrderButton() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        backgroundColor = Colors.General.selectedButton
        layer.cornerRadius = 10
        clipsToBounds = true
        setTitle("", for: .normal)
    }
    
// MARK: -
// MARK: - Setup Constraints
    
    private func setupConstraints() {
        layoutOrderLabel()
        layoutTimeDelivaryLabel()
        layoutAmountLabel()
    }

    private func layoutOrderLabel() {
        self.addSubview(orderLabel)
        
        let defaultLabelWidth = frame.size.width * 0.3
        
        NSLayoutConstraint.activate([
            orderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            orderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            orderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            orderLabel.widthAnchor.constraint(equalToConstant: defaultLabelWidth)
        ])
    }
    
    private func layoutTimeDelivaryLabel() {
        addSubview(timeDeliveryLabel)
        NSLayoutConstraint.activate([
            timeDeliveryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeDeliveryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            timeDeliveryLabel.trailingAnchor.constraint(equalTo: orderLabel.leadingAnchor, constant: 2)
        ])
    }
    
    private func layoutAmountLabel() {
        addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: orderLabel.trailingAnchor, constant: 2),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}

