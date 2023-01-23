//
//  BasketViewController.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 15.11.22.
//

import UIKit

class BasketViewController: UIViewController {
    
    static let id = String(describing: BasketViewController.self)
    
    // MARK: -
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movingBasketView: MovingBasketView!
    
    // MARK: -
    // MARK: - Private Properties
    
    private var basketIDs = [RealmBasketModel]()
    private let dispatchGroup = DispatchGroup()
    private var documents = [Document]()
    private var dishes = [DishModel]()
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        registerCells()
        setupOrderButton()
        setupMovingBasketViewDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.setGradientBackground()
        dishes.removeAll()
        basketIDs.removeAll()
        documents.removeAll()
        getBasketItems()
        getDataFromDataBase()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func registerCells() {
        let nib = UINib(nibName: String(describing: BasketTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: BasketTableViewCell.self))
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
    }
    
    private func setupMovingBasketViewDelegate() {
        movingBasketView.delegate = self
    }
    
    private func getBasketItems() {
        basketIDs = RealmManager<RealmBasketModel>().read()
    }
    
    private func getFilterDishesByID(ids: [RealmBasketModel]) {
        var filterArray: [DishModel] = []
        for dish in dishes {
            for id in ids {
                if dish.id == id.id {
                    filterArray.append(dish)
                }
            }
        }
        dishes = filterArray
    }
    
    private func getValueFromString(_ name: String) -> TypeOfDishesEnum? {
        for elem in TypeOfDishesEnum.allCases {
            if elem.rawValue == name {
                return elem
            }
        }
        return nil
    }
    
    private func setupOrderButton() {
        let order = "Заказать"
        let amount = "getTotalAmount()"
        let time = "45 - 50 мин"
        let model = OrderButtonModel(order: order, time: time, amount: amount)
        movingBasketView.orderButton.setupButtonLabels(model: model)
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
                guard let self else { return }
                self.getFilterDishesByID(ids: self.basketIDs)
                self.tableView.reloadData()
            }
            SpinnerView.shared.stopSpiner()
        }
    }
    
    private func findDishIndex(dishToDelete: DishModel) -> Int {
        for (index, dish) in dishes.enumerated() {
            if dish.id == dishToDelete.id {
                return index
            }
        }
        return 0
    }
}

// MARK: -
// MARK: - Extension UITableViewDataSource

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasketTableViewCell.self), for: indexPath)
        
        guard let basketCell = cell as? BasketTableViewCell else { return cell }
        
        basketCell.selectionStyle = .none
        basketCell.set(selectedModel: dishes[indexPath.row])
        basketCell.delegate = self
        basketCell.swipeGesture?.delegate = self
        return basketCell
    }
}

// MARK: -
// MARK: - Extension BasketTableViewCellDelegate

extension BasketViewController: BasketTableViewCellDelegate {
    func deleteCellFromTableView(dishToDelete: DishModel) {
        let indexToDelete = findDishIndex(dishToDelete: dishToDelete)
        let indexPathToDelete = IndexPath(item: indexToDelete, section: 0)
        let actualBasketArray =  RealmManager<RealmBasketModel>().read()
        
        guard let currentModel = actualBasketArray.filter({ $0.id == dishToDelete.id}).first else { return }
        
        RealmManager<RealmBasketModel>().delete(object: currentModel)
        dishes.remove(at: indexToDelete)
        tableView.deleteRows(at: [indexPathToDelete], with: .left)
        
        getBasketItems()
    }
}

// MARK: -
// MARK: - Extension BasketViewController + UIGestureRecognizerDelegate

extension BasketViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let velocity = gestureRecognizer.velocity(in: tableView)
        return abs(velocity.x) > abs(velocity.y)
    }
}

extension BasketViewController: MovingBasketViewDelegate {
    func getContentInsetValue(inset: CGFloat) {
        tableView.contentInset.bottom = inset
    }
}


