//
//  TypesOfDishesView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.11.22.
//

import UIKit

// MARK: -
// MARK: - Protocols

protocol TypesOfDishesViewDelegate: AnyObject {
    func getSelected(indexPath: IndexPath, typeOfDishes: TypeOfDishesEnum)
}

class TypesOfDishesView: UIView {
    
// MARK: -
// MARK: - IBOutlets

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
// MARK: -
// MARK: - Private Properties
    
    private var dishesType = TypeOfDishesEnum.allCases
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private var selectedDishesType: TypeOfDishesEnum = .kishes
    
    weak var delegate: TypesOfDishesViewDelegate?
    
// MARK: -
// MARK: - Lifecicle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
// MARK: -
// MARK: - Private Methods
    
    private func commonInit() {
        let id = String(describing: TypesOfDishesView.self)
        Bundle.main.loadNibNamed(id, owner: self)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registreCell()
    }
    
    private func registreCell() {
        let nib = UINib(nibName: TypesOfDishesCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TypesOfDishesCollectionViewCell.id)
    }
    
    private func calculateDishCollectionViewCellSize() -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / 4
        let cellHeight = cellWidth * 0.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: -
// MARK: - Extensions CollectionView DataSource

extension TypesOfDishesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TypeOfDishesEnum.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypesOfDishesCollectionViewCell.id, for: indexPath)
        guard let typeOfDishesCell = cell as? TypesOfDishesCollectionViewCell else { return cell }
        typeOfDishesCell.isSelected = selectedIndexPath == indexPath
        typeOfDishesCell.setupViewWith(typeOfDishes: dishesType[indexPath.row])
        
        return typeOfDishesCell
    }
}

// MARK: -
// MARK: - Extensions CollectionView Delegate

extension TypesOfDishesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateDishCollectionViewCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.selectedDishesType = dishesType[selectedIndexPath.row]
        delegate?.getSelected(indexPath: selectedIndexPath, typeOfDishes: selectedDishesType)
        self.collectionView.reloadData()
    }
}



