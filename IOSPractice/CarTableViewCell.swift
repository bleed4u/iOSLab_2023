//
//  CarTableViewCell.swift
//  IOSPractice
//
//  Created by Rustem on 10.10.2023.
//

import UIKit

protocol addToBasketDelegate {
    func didPressBacketButton(carModel: CarModel)
}
protocol deleteFromBasketDelegate {
    func didPressDeleteButton()
}

class CarTableViewCell: UITableViewCell {
    
    var delegate: addToBasketDelegate?
    
    var deleteDelegate: deleteFromBasketDelegate?
    
    private lazy var carNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var carImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .black
        return img
    }()
    
    private lazy var carPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let dateFormatter = DateFormatter()
    
    lazy var deleteButton: UIButton = {
        let basketAction = UIAction { _ in
            self.deleteDelegate?.didPressDeleteButton()
        }
        var button = UIButton(type: .system, primaryAction: basketAction)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("удалить", for: .normal)
        button.titleLabel?.tintColor = .white
        return button
    }()
    
    private lazy var toBasketButton: UIButton = {
        let basketAction = UIAction { _ in
            self.delegate?.didPressBacketButton(carModel: CarModel(carName: self.carNameLabel.text ?? "", imageName: "Volvokagen.png", carPrice: Int(self.carPriceLabel.text ?? "0") ?? 0))
        }
        var button = UIButton(type: .system, primaryAction: basketAction)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("в корзину", for: .normal)
        button.titleLabel?.tintColor = .white
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addSubviews(subviews: carNameLabel, carImageView, carPriceLabel, toBasketButton, deleteButton)
        deleteButton.isHidden = true
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with car: CarModel) {
        
        carNameLabel.text = car.carName
        carPriceLabel.text = "\(car.carPrice)"
        carImageView.image = UIImage(named: car.imageName)
    }
}

extension CarTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            carNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            carNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            carNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            carImageView.topAnchor.constraint(equalTo: carNameLabel.bottomAnchor, constant: 10),
            carImageView.leadingAnchor.constraint(equalTo: carNameLabel.leadingAnchor),
            carImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            carImageView.widthAnchor.constraint(equalToConstant: 100),
            carImageView.heightAnchor.constraint(equalToConstant: 100),
            
            carPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            carPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            toBasketButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            toBasketButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: carPriceLabel.topAnchor)
        ])
    }
}
