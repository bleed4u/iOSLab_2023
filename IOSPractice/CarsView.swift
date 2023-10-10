//
//  CarsView.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import UIKit

class CarsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dataManager1: DataManager){
        super.init(frame: .zero)
        self.dataManagerInView = dataManager1
        self.setupUI()
    }
    
    enum TableViewSections {
        case default1
    }
    var dataManagerInView: DataManager?
    
    lazy var cars: [CarModel] = (self.dataManagerInView?.cars) ?? []
    
    var delegate: addToBasketDelegate?
    
    var dataSource: UITableViewDiffableDataSource<TableViewSections, CarModel>?
    
    private lazy var carsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 60
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    
    
    private func setupUI(){
        
        
        self.addSubview(carsTableView)
        dataManagerInView?.addCar(CarModel(carName: "Volvokagen", imageName: "Volvokagen.png", carPrice: 100))
        dataManagerInView?.addCar(CarModel(carName: "Volvokagen", imageName: "Volvokagen.png", carPrice: 100))
        dataManagerInView?.addCar(CarModel(carName: "Volvokagen", imageName: "Volvokagen.png", carPrice: 12200))
        dataManagerInView?.addCar(CarModel(carName: "Volvokagen", imageName: "Volvokagen.png", carPrice: 2111))
        self.backgroundColor = .white
        print(dataManagerInView?.cars[0])
        setupDataSource()
        NSLayoutConstraint.activate([
            carsTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            carsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            carsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            carsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
}

extension CarsView: UITableViewDelegate {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: carsTableView, cellProvider: { tableView, indexPath, car in
            let cell = self.carsTableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
            cell.configureCell(with: car)
            cell.delegate = self.delegate
            return cell
        })
        self.updateData(with: self.cars, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let car = dataSource?.itemIdentifier(for: indexPath){
            print(car.carName)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func updateData(with cars: [CarModel], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<TableViewSections, CarModel>()
        snapshot.appendSections([.default1])
        snapshot.appendItems(cars)
        dataSource?.apply(snapshot, animatingDifferences: animated)
    }
}
