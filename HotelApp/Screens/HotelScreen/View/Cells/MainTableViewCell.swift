//
//  MainTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import UIKit
import SnapKit
import Kingfisher
//import SDWebImage

class MainTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private var imageNames: [String] = ["https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
         "https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
         "https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"]

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
    
    private lazy var firstView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = .white
        vieww.translatesAutoresizingMaskIntoConstraints = false
        vieww.layer.cornerRadius = 10
        
        return vieww
    }()
    
    private lazy var carousel: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = .black
        vieww.translatesAutoresizingMaskIntoConstraints = false
        vieww.layer.cornerRadius = 15
        
        return vieww
    }()
    
    private lazy var ratingView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(hexString: "#FFA800").withAlphaComponent(0.2)
        vieww.translatesAutoresizingMaskIntoConstraints = false
        vieww.layer.cornerRadius = 5
        
        return vieww
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#FFA800")
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        return label
    }()
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(hexString: "#0D72FF"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        
        button.addTarget(self, action: #selector(nomer), for: .touchUpInside)
        return button
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, addressButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 30)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var priceTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(hexString: "#828796")
        label.translatesAutoresizingMaskIntoConstraints = false
        
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

    //MARK: - Methods
    
    private func setUpViews() {
        
        contentView.addSubview(firstView)
        
        [ratingImage, ratingLabel].forEach {
            ratingView.addSubview($0)
        }
        
        setupCollectionView()
        setupPageControl()
        
        [carousel, ratingView, detailStackView, priceStackView].forEach {
            firstView.addSubview($0)
        }
        
        setConstraints()
    }
    
    @objc func nomer() {
//        self.navigationController?.pushViewController(NomerViewController(), animated: true)
    }
    
    func configure(with model: HotelModelProtocol) {
        nameLabel.text = model.name
        addressButton.setTitle(model.adress, for: .normal)
        priceLabel.text = model.price
        ratingLabel.text = model.rating + model.ratingName
        priceTextLabel.text = model.priceForIt
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
    
}

//MARK: - Constraints

extension MainTableViewCell {
    
    private func setConstraints() {
        firstView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        carousel.snp.makeConstraints { make in
            make.top.equalTo(firstView).offset(16)
            make.leading.equalTo(firstView).offset(16)
            make.trailing.equalTo(firstView).offset(-16)
            make.height.equalTo(257)
        }

        ratingView.snp.makeConstraints { make in
            make.top.equalTo(carousel.snp.bottom).offset(16)
            make.leading.equalTo(firstView).offset(16)
            make.trailing.equalTo(firstView).offset(-210)
            make.height.equalTo(37)
        }

        detailStackView.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(16)
            make.leading.equalTo(carousel)
            make.trailing.equalTo(firstView).offset(-16)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(detailStackView.snp.bottom).offset(16)
            make.leading.equalTo(carousel)
            make.trailing.equalTo(firstView).offset(-42)
        }

        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingView).offset(5)
            make.leading.equalTo(ratingView).offset(29)
            make.trailing.equalTo(ratingView).offset(-10)
            make.bottom.equalTo(ratingView).offset(-5)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(ratingView).offset(10)
            make.leading.equalTo(ratingView).offset(10)
            make.trailing.equalTo(ratingView).offset(-140)
            make.bottom.equalTo(ratingView).offset(-10)
        }
    }
}

extension MainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return imageNames.count
     }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath)
        
        // Проверяем, есть ли уже UIImageView в ячейке
        if let imageView = cell.contentView.viewWithTag(42) as? UIImageView {
            // Если есть, просто обновляем изображение
            imageView.kf.setImage(with: URL(string: imageNames[indexPath.item]))
        } else {
            // Если нет, добавляем новый UIImageView
            let imageView = UIImageView(frame: cell.contentView.bounds)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: imageNames[indexPath.item]))
            imageView.tag = 42 // Присваиваем тег, чтобы позже идентифицировать UIImageView
            
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
