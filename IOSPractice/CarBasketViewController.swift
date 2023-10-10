//
//  CarBasketView.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import UIKit

class CarBasketViewController: UIViewController {
    var dataManager: DataManager = DataManager()
    init(dataManager1: DataManager){
        super.init(nibName: nil, bundle: nil)
        self.dataManager = dataManager1
    }
    
    lazy var basketView = BasketView(dataManager1: self.dataManager)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        basketView.dataManagerInView = dataManager
        view = basketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Корзина"
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}
