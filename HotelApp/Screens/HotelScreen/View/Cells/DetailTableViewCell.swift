//
//  DetailTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 18.12.2023.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    private var peculiarities: [String] = []
    private var dataDetailView: [String] = ["Удобства", "Что включено", "Что не включено"]
    private var dataDetailImagesNames: [String] = ["happy", "tick", "close"]

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupDetailView()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Об отеле"
        
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Отель VIP"
        
        return label
    }()
    
    private lazy var upperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var overallStackView: UIStackView = {
        let overallStackView = UIStackView()
        overallStackView.axis = .vertical
        overallStackView.spacing = 8
        overallStackView.alignment = .leading
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        return overallStackView
    }()
    
    private lazy var detailView: UIView = {
        let vieww = UIView()
        vieww.layer.cornerRadius = 15
        vieww.backgroundColor = UIColor(hexString: "#FBFBFC")
        
        return vieww
    }()
    
    private lazy var detailStackView: UIStackView = {
        let overallStackView = UIStackView()
        overallStackView.axis = .vertical
        overallStackView.spacing = 8
        overallStackView.alignment = .leading
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        return overallStackView
    }()
    
    private lazy var nextDetailButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        [upperStackView].forEach {
            overallStackView.addArrangedSubview($0)
        }
        
        detailView.addSubview(detailStackView)
        
        [introLabel, overallStackView, detailLabel, detailView].forEach {
            contentView.addSubview($0)
        }
        
        print(peculiarities)
        setConstraints()
    }
    
    func configure(with model: HotelModelProtocol) {
        detailLabel.text = model.hotelDescription
        print("Configure: \(model.hotelPeculiraties)")
        peculiarities = model.hotelPeculiraties
        setupStackViews()
    }
    
    private func setupStackViews() {
        for (index, text) in peculiarities.enumerated() {
            let label = UILabel()
            label.text = text
            label.textAlignment = .left
            label.textColor = UIColor(hexString: "#828796")
            label.font = UIFont(name: "SF Pro Display", size: 16)
            label.font = UIFont.boldSystemFont(ofSize: 16)

            let container = UIView()
            container.backgroundColor = UIColor(hexString: "#FBFBFC")
            container.layer.cornerRadius = 5
            container.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.snp.makeConstraints { make in
                make.top.equalTo(container).offset(5)
                make.left.equalTo(container).offset(10)
                make.right.equalTo(container).offset(-10)
                make.bottom.equalTo(container).offset(-5)
                
            }
            
            if index == 0 {
                overallStackView.addArrangedSubview(container)
            }
            else if index == 1 || index == 2 {
                upperStackView.addArrangedSubview(container)
            } else {
                overallStackView.addArrangedSubview(upperStackView)
                overallStackView.addArrangedSubview(container)
            }
            upperStackView.spacing = 8
        }
    }
    
    private func setupDetailView() {
        
        for i in 0..<dataDetailView.count {
            let labelsStackView = UIStackView()
            labelsStackView.axis = .vertical
            labelsStackView.spacing = 2
            labelsStackView.alignment = .leading
            
            let buttonLabelsStackView = UIStackView()
            buttonLabelsStackView.axis = .horizontal
            buttonLabelsStackView.spacing = 120
            buttonLabelsStackView.alignment = .leading
            buttonLabelsStackView.distribution = .equalSpacing
            
            let overallHorizontalStackView = UIStackView()
            overallHorizontalStackView.axis = .horizontal
            overallHorizontalStackView.spacing = 10
            overallHorizontalStackView.alignment = .top
            overallHorizontalStackView.distribution = .equalSpacing
            
            let label = UILabel()
            label.text = dataDetailView[i]
            label.textAlignment = .center
            label.backgroundColor = .white
            label.font = UIFont(name: "SF Pro Display", size: 16)
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(hexString: "#2C3035")
            
            let label2 = UILabel()
            label2.text = "Самое необходимое"
            label2.font = UIFont(name: "SF Pro Display", size: 14)
            label2.font = UIFont.boldSystemFont(ofSize: 14)
            label2.textColor = UIColor(hexString: "#828796")
            label2.textAlignment = .center
            label2.backgroundColor = .white
            
            let next = UIButton()
            next.setImage(UIImage(named: "button"), for: .normal)
            
            let imageView = UIImageView(image: UIImage(named: dataDetailImagesNames[i]))
            imageView.contentMode = .scaleAspectFit

            [label, label2].forEach {
                labelsStackView.addArrangedSubview($0)
            }
            
            [labelsStackView, next].forEach {
                buttonLabelsStackView.addArrangedSubview($0)
            }
            
            [imageView, buttonLabelsStackView].forEach {
                overallHorizontalStackView.addArrangedSubview($0)
            }
            
            imageView.snp.makeConstraints { make in
//                make.height.equalTo(24)
//                make.width.equalTo(24)
                make.centerY.equalTo(overallHorizontalStackView.snp.centerY)
            }
            
            detailStackView.addArrangedSubview(overallHorizontalStackView)
            
            if detailStackView.arrangedSubviews.count < 5 {
                let separator = createSeparator()
                separator.backgroundColor = UIColor(hexString: "#828796").withAlphaComponent(15)
                detailStackView.addArrangedSubview(separator)
                separator.snp.makeConstraints { make in
                    make.height.equalTo(1)
                    make.leading.equalTo(overallHorizontalStackView.snp.leading)
                    make.trailing.equalTo(overallHorizontalStackView.snp.trailing)
                }
            }
        }
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        return separator
    }
}

//MARK: - Constraints

extension DetailTableViewCell {
    func setConstraints() {
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        overallStackView.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(overallStackView.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-64)
        }
        
        detailStackView.snp.makeConstraints { make in make.top.equalTo(detailView).offset(15)
            make.leading.equalTo(detailView).offset(15)
            make.trailing.equalTo(detailView).offset(-15)
            make.bottom.equalTo(detailView).offset(-15)
        }
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
        }
    }
}
