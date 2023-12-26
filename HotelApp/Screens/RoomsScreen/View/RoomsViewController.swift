//
//  RoomsViewController.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import UIKit
import SnapKit

class RoomsViewController: UIViewController {
    
    private var presenter: RoomsPresenterProtocol
    
    //MARK: - Init
    
    init(presenter: RoomsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = titleLabel
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadView { [weak self] in
            self?.tableView.reloadData()
            self?.setUpViews()
        }
    }
    
    //MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Лучший пятизвездочный отель в Хургаде, Египет"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RoomsTableViewCell.self, forCellReuseIdentifier: "roomCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "#F6F6F9")
        return tableView
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        setBackButton()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
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
}

extension RoomsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as? RoomsTableViewCell else {
                    return UITableViewCell()
            }
            cell.layer.cornerRadius = 12
            cell.configure(with: presenter.model())
            RoomsModel.roomIndex += 1
            cell.buttonTappedClosure = {
                self.navigationController?.pushViewController(Main.shared.bookingScreen(), animated: true)
                RoomsModel.roomIndex = 0
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as? RoomsTableViewCell else {
                    return UITableViewCell()
            }
            cell.layer.cornerRadius = 12
            cell.backgroundColor = .yellow
            cell.configure(with: presenter.model())
            cell.buttonTappedClosure = {
                self.navigationController?.pushViewController(Main.shared.bookingScreen(), animated: true)
                RoomsModel.roomIndex = 0
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        560
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.model().roomsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}


//MARK: - RoomsViewProtocol

extension RoomsViewController: RoomsViewProtocol {
    func updateView() {
//        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        if isLoading {
            let loadingIndicator = UIActivityIndicatorView(style: .large)
            loadingIndicator.startAnimating()
            loadingIndicator.center = view.center
            view.addSubview(loadingIndicator)
        } else {
            view.subviews.filter { $0 is UIActivityIndicatorView }.forEach { $0.removeFromSuperview() }
        }
    }
    
    func updateView(withError message: String) {}
}

