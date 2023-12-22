//
//  RoomsTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 20.12.2023.
//

import UIKit
import SnapKit

class RoomsTableViewCell: UITableViewCell {
    
    
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private var imageNames: [String] = ["https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
         "https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
         "https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"]
    private var peculiarities: [String] = []
    
    var buttonTappedClosure: (() -> Void)?

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
    
    private lazy var carousel: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = .black
        vieww.translatesAutoresizingMaskIntoConstraints = false
        vieww.layer.cornerRadius = 15
        
        return vieww
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var overallStackView: UIStackView = {
        let overallStackView = UIStackView()
        overallStackView.axis = .vertical
        overallStackView.spacing = 8
        overallStackView.alignment = .leading
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        return overallStackView
    }()
    
    private lazy var moreButtonView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(hexString: "#0D72FF").withAlphaComponent(0.1)
        return vieww
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hexString: "#0D72FF"), for: .normal)
        button.setTitle("Подробнее о номере", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        return button
    }()
    
    private lazy var moreButtonAArrow: UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "arrow-blue"))
        return imageview
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 30)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    private lazy var priceTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(hexString: "#828796")
        
        return label
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, priceTextLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var buttonChoose: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#0D72FF")
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.setTitle("Выбрать номер", for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()

    
    //MARK: - Methods
    
    private func setUpViews() {
        contentView.backgroundColor = UIColor(hexString: "#FFFFFF")
        
        [moreButton, moreButtonAArrow].forEach {
            moreButtonView.addSubview($0)
        }
        
        [carousel, nameLabel, overallStackView, moreButtonView, priceStackView, buttonChoose].forEach {
            contentView.addSubview($0)
        }
        
        setupCollectionView()
        setupPageControl()
        setConstraints()
    }
    
    func configure(with model: RoomsModelProtocol) {
        nameLabel.text = model.name
        peculiarities = model.peculiarities
        setupPeculiaritiesStackViews()
        priceLabel.text = model.price
        priceTextLabel.text = model.pricePer
    }
    
    private func setupPeculiaritiesStackViews() {
        var horizontalStackView: UIStackView?
        
        for (_, text) in peculiarities.enumerated() {
            let label = UILabel()
            label.text = text
            label.textAlignment = .left
            label.textColor = UIColor(hexString: "#828796")
            label.font = UIFont(name: "SF Pro Display", size: 16)
            label.font = UIFont.boldSystemFont(ofSize: 16)

            let container = UIView()
            container.backgroundColor = UIColor(hexString: "#FBFBFC")
//            container.backgroundColor = .red
            container.layer.cornerRadius = 5
            container.addSubview(label)
            

            label.snp.makeConstraints { make in
                make.top.equalTo(container).offset(5)
                make.left.equalTo(container).offset(10)
                make.right.equalTo(container).offset(-10)
                make.bottom.equalTo(container).offset(-5)
            }
        
            if horizontalStackView == nil {
                horizontalStackView = createHorizontalStackView()
            }
            
            horizontalStackView?.addArrangedSubview(container)
            
            if horizontalStackView?.arrangedSubviews.count == 2 {
                overallStackView.addArrangedSubview(horizontalStackView!)
                horizontalStackView = nil
            }
        }
        
        if let horizontalStackView = horizontalStackView {
            overallStackView.addArrangedSubview(horizontalStackView)
        }
    }

    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: carousel.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CarouselCell")
        
        carousel.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.backgroundColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.layer.cornerRadius = 5
        
        carousel.addSubview(pageControl)
        
//        pageControl.snp.makeConstraints { make in
//            make.centerX.equalTo(carousel)
//            make.bottom.equalTo(carousel).offset(-20)
//            make.height.equalTo(17)
//            make.width.equalTo(pageControl.size(forNumberOfPages: pageControl.numberOfPages).width + 20)
//        }
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: carousel.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: carousel.bottomAnchor, constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 17),
//            pageControl.widthAnchor.constraint(equalTo: pageControl.widthAnchor, constant: 5) // Устанавливаем ширину с отступами
        ])
    }
    
    @objc func nextPage() {
        buttonTappedClosure?()
    }
}

//MARK: - Constraints

extension RoomsTableViewCell {
    private func setConstraints() {
        
        carousel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(257)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(carousel.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        overallStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        moreButtonView.snp.makeConstraints { make in
            make.top.equalTo(overallStackView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-167)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(moreButtonView).offset(5)
            make.leading.equalTo(moreButtonView).offset(10)
            make.bottom.equalTo(moreButtonView).offset(-5)
        }
        
        moreButtonAArrow.snp.makeConstraints { make in
            make.top.equalTo(moreButtonView).offset(4)
            make.leading.equalTo(moreButton.snp.trailing).offset(2)
            make.trailing.equalTo(moreButtonView).offset(-2)
            make.bottom.equalTo(moreButtonView).offset(-4)
//            make.height.equalTo(24)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(moreButtonView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-42)
        }
        
        buttonChoose.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
}


extension RoomsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return imageNames.count
     }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
        
        if let imageView = cell.contentView.viewWithTag(42) as? UIImageView {
            imageView.kf.setImage(with: URL(string: imageNames[indexPath.item]))
        } else {
            let imageView = UIImageView(frame: cell.contentView.bounds)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: imageNames[indexPath.item]))
            imageView.tag = 42
            
            cell.contentView.addSubview(imageView)
            
            imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
        
        return cell
    }
     
     // MARK: - UICollectionViewDelegateFlowLayout
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return collectionView.bounds.size
     }
     
     // MARK: - UIScrollViewDelegate
     
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let pageIndex = round(scrollView.contentOffset.x / carousel.frame.width)
         pageControl.currentPage = Int(pageIndex)
     }
}

