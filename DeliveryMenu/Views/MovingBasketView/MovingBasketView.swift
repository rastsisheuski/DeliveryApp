//
//  MovingBasketView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 1.12.22.
//

protocol MovingBasketViewDelegate: AnyObject {
    func getContentInsetValue(inset: CGFloat)
}

import UIKit

// MARK: -
// MARK: - Checkign height of MovingBasketView

class TestView: UIView {
    weak var delegate: MovingBasketViewDelegate?
    
    override var bounds: CGRect {
        didSet {
            delegate?.getContentInsetValue(inset: bounds.height - Constants.TabBar.tbBarHegiht)
        }
    }
}

class MovingBasketView: TestView {
    
// MARK: -
// MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var orderButton: OrderButton!
    @IBOutlet weak var hookView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: SelfSizingTableView!
    
    // MARK: -
// MARK: - Private Peroperties
    
    private var leadingBeginGestureConstant: CGFloat = 0
    private var trailingBeginGestureConstant: CGFloat = 0
    private var totalCount = 0 {
        didSet {
            
        }
    }
    private let defaultDeliveryCount = 300
    private var defaultDeliveryInfo: MovingBasketViewCellModel?
    private var defaultTotalInfo: MovingBasketViewCellModel?
    private var tableViewData: [MovingBasketViewCellModel] = []
    
// MARK: -
// MARK: - LifeCycle
    
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
        let id = String(describing: MovingBasketView.self)
        Bundle.main.loadNibNamed(id, owner: self)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        
        setupUI()
        setupTableView()
        setupGesture()
        delegate?.getContentInsetValue(inset: self.bounds.height)
    }
    
    private func setupUI() {
        setupMovingView()
        setGradientBackground()
        setupDefaultInfoForCells(with: defaultDeliveryCount)
        mainView.isUserInteractionEnabled = false
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.separatorStyle = .none
        
        registerCell()
    }
    
    private func showTotalPrice() {
        guard let defaultTotalInfo else { return }
        
        if tableViewData.contains(defaultTotalInfo) {
            return
        }
        tableViewData.append(defaultTotalInfo)
        tableView.reloadData()
        animateTableView()
    }
    
    private func hideTotalPrice() {
        guard let defaultTotalInfo else { return }
        
        if !tableViewData.contains(defaultTotalInfo) {
            return
        }
        
        for (index,item) in tableViewData.enumerated() {
            if item == defaultTotalInfo {
                tableViewData.remove(at: index)
            }
        }
        
        tableView.reloadData()
        animateTableView()
    }
    
    private func animateTableView() {
        delegate?.getContentInsetValue(inset: self.bounds.height)
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.mainView.layoutIfNeeded()
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: String(describing: MovingBasketViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: MovingBasketViewCell.self))
    }
    
    private func setupDefaultInfoForCells(with deliveryPrice: Int) {
        defaultDeliveryInfo = MovingBasketViewCellModel(
            image: Icons.deliveryBasketIcon.image,
            title: "Доставка",
            amount: deliveryPrice
        )
        
        defaultTotalInfo = MovingBasketViewCellModel(
            image: Icons.totalBasketIcon.image,
            title: "Итого:",
            amount: deliveryPrice
        )
        
        guard let defaultDeliveryInfo else { return }
        
        tableViewData.append(defaultDeliveryInfo)
    }
    
    private func setupMovingView() {
        self.layer.cornerRadius = 40
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner,  .layerMinXMinYCorner]
    }
    
    private func setupGesture() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down]
        for direction in directions {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToPanGesture(sender:)))
            swipe.direction = direction
            self.addGestureRecognizer(swipe)
        }
    }
}

// MARK: -
// MARK: - Extension MovingBasketView + UITableViewDataSource

extension MovingBasketView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovingBasketViewCell.self), for: indexPath)
        (cell as? MovingBasketViewCell)?.set(model: tableViewData[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: -
// MARK: - Extension MovingBasketView + UIPanGestureRecognizer Action

extension MovingBasketView {
    @objc private func respondToPanGesture(sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
            case .up:
                showTotalPrice()
            case .down:
                hideTotalPrice()
            default: return
        }
    }
}


