//
//  SuccessViewController.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 26.12.2023.
//

import UIKit
import SnapKit

class SuccessViewController: UIViewController {
    
    //MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = titleLabel
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.size.width / 2
        circleView.clipsToBounds = true
    }
    
    //MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Заказ оплачен"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var circleView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(hexString: "#F6F6F9")
        vieww.clipsToBounds = true
        return vieww
    }()
    
    private lazy var partyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Party")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var bigLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Ваш заказ принят в работу"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var smallLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor(hexString: "#828796")
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var buttonOkay: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#0D72FF")
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.setTitle("Супер!", for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(okay), for: .touchUpInside)

        return button
    }()
    
    //MARK: - Methods
    
    private func setBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "arrowBack"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: backButton)

        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func okay() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setUpViews() {
        setBackButton()
        
        circleView.addSubview(partyImageView)
        
        [circleView, bigLabel, smallLabel, buttonOkay].forEach {
            view.addSubview($0)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        circleView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(223)
            make.leading.equalTo(view).offset(140)
            make.trailing.equalTo(view).offset(-141)
            make.width.equalTo(94)
            make.height.equalTo(112)
        }
        
        bigLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(32)
            make.leading.equalTo(view).offset(16)
            make.trailing.equalTo(view).offset(-16)
        }
        
        smallLabel.snp.makeConstraints { make in
            make.top.equalTo(bigLabel.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(23)
            make.trailing.equalTo(view).offset(-23)
        }
        
        partyImageView.snp.makeConstraints { make in
            make.centerX.equalTo(circleView.snp.centerX)
            make.centerY.equalTo(circleView.snp.centerY)
        }
        
        buttonOkay.snp.makeConstraints { make in
            make.trailing.equalTo(view).offset(-16)
            make.leading.equalTo(view).offset(16)
            make.bottom.equalTo(view).offset(-28)
            make.height.equalTo(48)
        }
    }
}
