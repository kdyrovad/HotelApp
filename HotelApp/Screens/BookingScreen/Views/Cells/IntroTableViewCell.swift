//
//  IntroTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//

import UIKit
import SnapKit

class IntroTableViewCell: UITableViewCell {

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy var ratingView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(hexString: "#FFA800").withAlphaComponent(0.2)
        vieww.layer.cornerRadius = 5
        return vieww
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#FFA800")
        label.text = "5 Rating"
        
        return label
    }()
    
    private lazy var ratingImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Star"))
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "NameLabel"
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(hexString: "#0D72FF"), for: .normal)
        button.setTitle("Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.alignment = .leading
//        stackView.backgroundColor = .blue
        return stackView
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        [ratingImage, ratingLabel].forEach {
            ratingView.addSubview($0)
        }
        
        [ratingView, nameLabel, addressButton].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        
        setConstraints()
    }
    
    func configure(with model: BookingModelProtocol) {
        nameLabel.text = model.hotelName
        addressButton.setTitle(model.adress, for: .normal)
        ratingLabel.text = model.rating
    }
}

//MARK: - Constraints

extension IntroTableViewCell {
    private func setConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView).offset(5)
            make.leading.equalTo(ratingView).offset(29)
            make.trailing.equalTo(ratingView).offset(-10)
            make.bottom.equalTo(ratingView).offset(-5)
        }

        ratingImage.snp.makeConstraints { make in
//            make.width.equalTo(24)
//            make.height.equalTo(24)
            make.top.equalTo(ratingView).offset(10)
            make.leading.equalTo(ratingView).offset(10)
            make.trailing.equalTo(ratingView).offset(-140)
            make.bottom.equalTo(ratingView).offset(-10)
//            make.height.equalTo(37)
        }
        
        ratingView.snp.makeConstraints { make in
            make.height.equalTo(37)
        }
        
        nameLabel.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor).isActive = true
//        nameLabel.snp.makeConstraints { make in
//            make.height.equalTo(60)
//        }
    }
}
