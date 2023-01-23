//
//  BasketTableViewCell.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 15.11.22.
//

protocol BasketTableViewCellDelegate: AnyObject {
    func deleteCellFromTableView(dishToDelete: DishModel)
}

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    weak var delegate: BasketTableViewCellDelegate?
    
// MARK: -
// MARK: - IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
// MARK: -
// MARK: - Private Properties
    
    private var dishModelToDelete: DishModel?
    private var customBasketItemLeadingConstraint: NSLayoutConstraint!
    private var customBasketItemTrailingConstraint: NSLayoutConstraint!
    private let customBasketItemBaseLeadingConstant: CGFloat = 0
    private let customBasketItemBaseTrailingConstant: CGFloat = 0
    private var leadingBeginGestureConstant: CGFloat = 0
    private var trailingBeginGestureConstant: CGFloat = 0
    private let separationConstraint: CGFloat = 16
    private var customBasketItemView: CustomBasketItemView = {
        let view = CustomBasketItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var swipeGesture: UIPanGestureRecognizer?
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layoutBasketItemView()
        self.setupGesture()
        self.setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.customBasketItemView.imageView.image = nil
        self.customBasketItemLeadingConstraint.constant = customBasketItemBaseLeadingConstant
        self.customBasketItemTrailingConstraint.constant = customBasketItemBaseTrailingConstant
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        self.mainView.layer.cornerRadius = 30
        self.mainView.clipsToBounds = true
    }
    
    func set(selectedModel: DishModel) {
        self.dishModelToDelete = selectedModel
        customBasketItemView.set(selectedModel: selectedModel)
    }
    
    private func layoutBasketItemView() {
        contentView.addSubview(customBasketItemView)
        
        NSLayoutConstraint.activate([
            customBasketItemView.topAnchor.constraint(equalTo: mainView.topAnchor),
            customBasketItemView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        customBasketItemLeadingConstraint = customBasketItemView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor)
        customBasketItemTrailingConstraint = customBasketItemView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        
        customBasketItemLeadingConstraint.isActive = true
        customBasketItemTrailingConstraint.isActive = true
    }
    
    private func setupGesture() {
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(respondToPanGesture(sender: )))
        swipeGesture = swipe
        self.customBasketItemView.addGestureRecognizer(swipe)
    }
    
    private func moveToStartPosition() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let self else { return }
            self.customBasketItemLeadingConstraint.constant = self.customBasketItemBaseLeadingConstant
            self.customBasketItemTrailingConstraint.constant = self.customBasketItemBaseTrailingConstant
            self.layoutIfNeeded()
        }
    }
    
    private func moveToDeleteButtonPosition() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let self else { return }
            self.customBasketItemTrailingConstraint.constant = self.customBasketItemBaseTrailingConstant - self.deleteButton.frame.width - self.separationConstraint
            self.customBasketItemLeadingConstraint.constant = self.customBasketItemBaseLeadingConstant - self.deleteButton.frame.width - self.separationConstraint
            self.customBasketItemTrailingConstraint.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    private func moveToEndPosition(completion: @escaping (() -> ()?)) {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let self else { return }
            self.customBasketItemTrailingConstraint.constant = self.customBasketItemBaseTrailingConstant - UIScreen.main.bounds.width
            self.customBasketItemLeadingConstraint.constant = self.customBasketItemBaseLeadingConstant - self.deleteButton.frame.width - UIScreen.main.bounds.width
            self.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    @IBAction func didDeletebuttonTapped(_ sender: UIButton) {
        moveToEndPosition { [weak self] in
            guard let self else { return }
            guard let dishModelToDelete = self.dishModelToDelete else { return }
            self.delegate?.deleteCellFromTableView(dishToDelete: dishModelToDelete)
        }
    }
}

// MARK: -
// MARK: - Extension Objc Methods

extension BasketTableViewCell {
    @objc private func respondToPanGesture(sender: UIPanGestureRecognizer) {
        // даёт понятие в какую сторону у нас свайп (+ -- вправо, - -- влево)
        let xVelocity = sender.velocity(in: customBasketItemView).x
        switch sender.state {
            case .began:
                print("начало движения")
                leadingBeginGestureConstant = customBasketItemLeadingConstraint.constant
                trailingBeginGestureConstant = customBasketItemTrailingConstraint.constant
            case .changed:
                let newLeadingConstant = leadingBeginGestureConstant + sender.translation(in: mainView).x
                let newTrailingConstant = trailingBeginGestureConstant + sender.translation(in: mainView).x
                
                guard newLeadingConstant <= customBasketItemBaseLeadingConstant else {
                    customBasketItemLeadingConstraint.constant = customBasketItemBaseLeadingConstant
                    customBasketItemTrailingConstraint.constant = customBasketItemBaseTrailingConstant
                    return
                }
                
                customBasketItemLeadingConstraint.constant = newLeadingConstant
                customBasketItemTrailingConstraint.constant = newTrailingConstant
            
                print(xVelocity)
            case .ended:
                if customBasketItemView.frame.maxX > mainView.frame.maxX / 1.3 {
                    print("Вернуть в исходное положение")
                    moveToStartPosition()
                } else if customBasketItemView.frame.maxX > mainView.frame.maxX / 2 {
                   print("Вернуться в положение кнопки")
                    moveToDeleteButtonPosition()
                } else {
                    print("Перейти в положение удалить")
                    moveToEndPosition { [weak self] in
                        guard let self else { return }
                        guard let dishModelToDelete = self.dishModelToDelete else { return }
                        self.delegate?.deleteCellFromTableView(dishToDelete: dishModelToDelete)
                    }
                }
            default:
                print("Failed")
        }
    }
}
