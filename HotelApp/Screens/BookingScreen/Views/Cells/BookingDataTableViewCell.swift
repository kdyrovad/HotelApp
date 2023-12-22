//
//  BookingDataTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//

import UIKit
import SnapKit

class BookingDataTableViewCell: UITableViewCell {
    
    private var dataNames: [String] = []
    private var dataLabelNames: [String] = ["Вылет из", "Страна,город", "Даты", "Кол-во ночей", "Отель", "Номер", "Питание"]

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
//        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.spacing = 16
        verticalStackView.alignment = .leading
        return verticalStackView
    }()

    //MARK: - Methods
    
    private func setUpViews() {
        for (index, text) in dataNames.enumerated() {
            let label = UILabel()
            label.font = UIFont(name: "SF Pro Display", size: 16)
            label.textColor = UIColor(hexString: "#828796")
            label.text = dataLabelNames[index]
            
            let labelData = UILabel()
            labelData.font = UIFont(name: "SF Pro Display", size: 16)
            labelData.textColor = .black
            labelData.numberOfLines = 0
            labelData.text = text
            
            let labelDataView = UIView()
            
            labelDataView.addSubview(label)
            
            label.snp.makeConstraints { $0.edges.equalToSuperview() }
            
            let stackView = UIStackView(arrangedSubviews: [labelDataView, labelData])
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.spacing = 8
            stackView.alignment = .fill
            
            verticalStackView.addArrangedSubview(stackView)
        }
        
        contentView.addSubview(verticalStackView)
        setConstraints()
    }
    
    func configure(with model: BookingModelProtocol) {
        dataNames = model.detailData
        setUpViews()
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        for stackView in verticalStackView.arrangedSubviews {
            if let horizontalStackView = stackView as? UIStackView {
                horizontalStackView.snp.makeConstraints { make in
                    make.leading.equalTo(verticalStackView)
                }

                for labelData in horizontalStackView.arrangedSubviews where labelData is UILabel {
                    labelData.snp.makeConstraints { make in
                        make.leading.equalTo(horizontalStackView).offset(156) // Замените это значение на необходимое вам
                    }
                }
            }
        }
    }
}
