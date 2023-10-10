//
//  CarModel.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import Foundation

struct CarModel: Hashable, Identifiable {
    let id = UUID()
    var carName: String
    var imageName: String
    var carPrice: Int
}
