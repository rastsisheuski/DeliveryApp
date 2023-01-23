//
//  LoginViewControllerView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 25.12.22.
//

import UIKit

class LoginViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.loginBackgroundImage.image
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.logoImage.image
        return imageView
    }()
    
    let logoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fox Delivery"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let bottomView: LoginBottomView = {
        let view = LoginBottomView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func layoutElements() {
        layoutBackgroundImageView()
        layoutLogoImageView()
        LayoutLogoTitleLabel()
        leyoutBotomView()
    }
    
    private func layoutBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
    }
    
    private func layoutLogoImageView() {
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func LayoutLogoTitleLabel() {
        addSubview(logoTitleLabel)
        
        NSLayoutConstraint.activate([
            logoTitleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            logoTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func leyoutBotomView() {
        addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: logoTitleLabel.bottomAnchor, constant: 20),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
