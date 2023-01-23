//
//  MainViewController.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.11.22.
//

import UIKit

class DishesViewController: UIViewController {
    
    static let id = String(describing: DishesViewController.self)
    
// MARK: -
// MARK: - IBOutlets
    
    @IBOutlet weak var typesOfDishesView: TypesOfDishesView!
    @IBOutlet weak var dishesCollectionView: UICollectionView!
    
    // MARK: -
    // MARK: - Private Properties
    
    private var basketIDs: [RealmBasketModel]?
    private var documents = [Document]()
    private var dishes = [DishModel]()
    private var filterDishes = [DishModel]()
    private var selectedTypeOfDishes:TypeOfDishesEnum = .kishes
    private var selectedIndex = IndexPath(row: 0, section: 0)
    private let dispatchGroup = DispatchGroup()
    
// MARK: -
// MARK: - Lifecicle

    override func viewDidLoad() {
        super.viewDidLoad()
        getActualBasketIDs()
        
        setupDishesCollectionView()
        typesOfDishesView.delegate = self
    
        getDataFromDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setGradientBackground()
        getActualBasketIDs()
        self.dishesCollectionView.reloadData()
    }

// MARK: -
// MARK: - Private Methods
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            //let translation = panGestureRecognizer.translation(in: superview!)
            let translation = panGestureRecognizer.translation(in: self.view)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    private func createFilterDishes() {
        filterDishes = dishes.filter { $0.type == selectedTypeOfDishes }
    }
    
    private func getActualBasketIDs() {
        basketIDs = RealmManager<RealmBasketModel>().read()
    }
    
    private func setupDishesCollectionView() {
        let nib = UINib(nibName: String(describing: DishCollectionViewCell.self), bundle: nil)
        dishesCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: DishCollectionViewCell.self))
        dishesCollectionView.delegate = self
        dishesCollectionView.dataSource = self
//        dishesCollectionView.contentInset.bottom = 200
    }
    
    private func calculateDishCollectionViewCellSize() -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2)
        let cellHeight = cellWidth * 1.6
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func getValueFromString(_ name: String) -> TypeOfDishesEnum? {
        for elem in TypeOfDishesEnum.allCases {
            if elem.rawValue == name {
                return elem
            }
        }
        return nil
    }
    
    private func convertFromDocToDish(completion: @escaping () -> Void) {
        var dishesArray = [DishModel]()
        for doc in documents {
            let name = doc.nameField
            let volume = doc.volumeField
            let nameOfDishesType = doc.dataFolderName
            let id = doc.id
            
            guard let price = Int(doc.priceField) else { return }
            guard let typeOfDishes = getValueFromString(nameOfDishesType) else { return }
            
            let dishModel = DishModel(name: name, type: typeOfDishes, weightOrVolume: volume, price: price, pictureFolderName: doc.imageFolderName, pictureName: doc.imageName, id: id)
            dishesArray.append(dishModel)
        }
        dishes = dishesArray
        completion()
    }
    
    private func getDataFromDataBase() {
        SpinnerView.shared.createSpiner()
    
        for type in TypeOfDishesEnum.allCases {
            dispatchGroup.enter()
            print("enter")
            APIManager.shared.getPost(collection: type.rawValue) { [weak self] doc in
                guard let doc else { return }
                guard let self else { return }
                
                self.documents += doc
                self.dispatchGroup.leave()
                print("leave")
                
            } failure: {
                print("Ошибка")
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.convertFromDocToDish { [weak self] in
                self?.createFilterDishes()
                self?.dishesCollectionView.reloadData()
            }
            SpinnerView.shared.stopSpiner()
        }
    }
}

// MARK: -
// MARK: - Extensions CollectionView Delegate

extension DishesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateDishCollectionViewCellSize()
    }
}

// MARK: -
// MARK: - Extensions CollectionView DataSource

extension DishesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DishCollectionViewCell.self), for: indexPath)
        guard let dishCell = cell as? DishCollectionViewCell else { return cell }
        guard let basketIDs else { return cell }
        
        let currentDish = filterDishes[indexPath.row]
        var isInBasket = false
        
        for basketModel in basketIDs {
            if basketModel.id == currentDish.id {
                isInBasket = true
            }
        }
        
        dishCell.set(for: currentDish, isInBasket: isInBasket)
        dishCell.delegate = self
        
        return dishCell
    }
}

// MARK: -
// MARK: - Extensions TypesOfDishesViewDelegate

extension DishesViewController: TypesOfDishesViewDelegate {
    func getSelected(indexPath: IndexPath, typeOfDishes: TypeOfDishesEnum) {
        self.selectedIndex = indexPath
        self.selectedTypeOfDishes = typeOfDishes
        
        self.createFilterDishes()
        self.dishesCollectionView.reloadData()
    }
}

// MARK: -
// MARK: - Extensions DishCollectionViewCellDelegate

extension DishesViewController: DishCollectionViewCellDelegate {
    func addDishToBasket(id: String) {
        let basketModel = RealmBasketModel(id: id)
        RealmManager<RealmBasketModel>().write(object: basketModel)
        
        getActualBasketIDs()
    }
    
    func removeDishFromBasket(id: String) {
        let actualBasketArray =  RealmManager<RealmBasketModel>().read()
        guard let currentModel = actualBasketArray.filter({ $0.id == id }).first else { return }
        RealmManager<RealmBasketModel>().delete(object: currentModel)
        
        getActualBasketIDs()
    }
}


