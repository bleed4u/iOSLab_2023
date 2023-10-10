//
//  BasketView.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import UIKit

class BasketView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    enum TableViewSections {
        case default1
    }
    
    init(dataManager1: DataManager){
        super.init(frame: .zero)
        self.dataManagerInView = dataManager1
        self.setupUI()
    }
    
    var dataManagerInView: DataManager?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cars: [CarModel] = (self.dataManagerInView?.carsInBasket) ?? []
    
    var dataSource: UITableViewDiffableDataSource<TableViewSections, CarModel>?
    
    var deleteDelegate: deleteFromBasketDelegate?
    
    private lazy var countLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(cars.count)"
        return label
    }()
    
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
        self.addSubview(countLabel)
        self.backgroundColor = .white
        setupDataSource()
        NSLayoutConstraint.activate([
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -20),
            countLabel.widthAnchor.constraint(equalToConstant: 20),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            carsTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            carsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            carsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            carsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
}

extension BasketView: UITableViewDelegate {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: carsTableView, cellProvider: { tableView, indexPath, car in
            let cell = self.carsTableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as! CarTableViewCell
            cell.configureCell(with: car)
            cell.deleteDelegate = self.deleteDelegate
            cell.deleteButton.isHidden = false
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
