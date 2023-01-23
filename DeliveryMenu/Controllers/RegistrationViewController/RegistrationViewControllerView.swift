//
//  RegistrationViewControllerView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 18.12.22.
//

import UIKit

class RegistrationViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.loginBackgroundImage.image
        return imageView
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .white
        return button
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
    
    let bottomView: RegistrationBottomView = {
        let view = RegistrationBottomView()
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
        layoutBackButton()
        layoutLogoImageView()
        layoutLogoTitleLabel()
        layoutBottomView()
    }
    
    private func layoutBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
    }
    
    private func layoutBackButton() {
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,  constant: 16)
        ])
    }
    
    private func layoutLogoImageView() {
        addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    private func layoutLogoTitleLabel() {
        addSubview(logoTitleLabel)
        NSLayoutConstraint.activate([
            logoTitleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            logoTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutBottomView() {
        addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: logoTitleLabel.bottomAnchor, constant: 20),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
