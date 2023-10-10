//
//  ViewController.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var dataManager = DataManager()
    
    lazy var carsView = CarsView(dataManager1: dataManager)
    
    override func loadView() {
        dataManager.addCar(CarModel(carName: "Volvokagen", imageName: "Volvokagen.png", carPrice: 100))
        print(dataManager.cars[0])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carsView.delegate = self
        dataManager.addCar(CarModel(carName: "Volvokagen", imageName: "Volvokagen.png", carPrice: 100))
        carsView.dataManagerInView = dataManager
        view = carsView
        self.navigationItem.title = "Магазин машинок"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Корзина", style: .plain, target: self, action: #selector(didTapBasketButton))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc private func didTapBasketButton() {
        let vc = CarBasketViewController(dataManager1: self.dataManager)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: addToBasketDelegate{
    func didPressBacketButton(carModel: CarModel) {
        dataManager.addCarToBasket(carModel)
        print(carModel.carName)
    }
}

