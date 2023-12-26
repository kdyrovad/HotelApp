//
//  PayButtonTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 26.12.2023.
//

import UIKit

protocol PayButtonTableViewCellDelegate: AnyObject {
    func didTapPayButton()
}

class PayButtonTableViewCell: UITableViewCell {
    
    
    weak var delegate: PayButtonTableViewCellDelegate?
    
    //MARK: - Views
    
    private lazy var buttonChoose: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#0D72FF")
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.setTitle("Оплатить", for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)

        return button
    }()

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        contentView.backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Methods
    
    @objc func pay() {
        NotificationCenter.default.post(name: NSNotification.Name("PayButtonPressed"), object: nil)
    }
    
    //MARK: - Constraints
    
    private func setConstraints() {
        contentView.addSubview(buttonChoose)
        
        buttonChoose.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-12)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }

}
