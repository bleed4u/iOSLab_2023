//
//  DataManager.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import Foundation

class DataManager {
    lazy var cars: [CarModel] = []
    
    lazy var carsInBasket: [CarModel] = []
    
    lazy var addCar: (CarModel) -> Void = { car in
        self.cars.append(car)
    }
    
    lazy var addCarToBasket: (CarModel) -> Void = { car in
        self.carsInBasket.append(car)
    }
}
