//
//  BookingViewController.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 20.12.2023.
//

import UIKit

class BookingViewController: UIViewController {
    
    private var presenter: BookingPresenterProtocol

    //MARK: - Init
    
    init(presenter: BookingPresenterProtocol) {
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
        titleLabel.text = "Бронирование"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IntroTableViewCell.self, forCellReuseIdentifier: "introCell")
        tableView.register(BookingDataTableViewCell.self, forCellReuseIdentifier: "dataCell")
        tableView.register(ClientDataTableViewCell.self, forCellReuseIdentifier: "clientDataCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "#F6F6F9")
        return tableView
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
    
    private func setUpViews() {
        setBackButton()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "introCell", for: indexPath) as? IntroTableViewCell else {
                return UITableViewCell()
            }
            cell.layer.cornerRadius = 12
            cell.configure(with: presenter.model())
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? BookingDataTableViewCell else {
                return UITableViewCell()
            }
            cell.layer.cornerRadius = 12
            cell.configure(with: presenter.model())
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "clientDataCell", for: indexPath) as? ClientDataTableViewCell else {
                return UITableViewCell()
            }
            cell.layer.cornerRadius = 12
//            cell.configure(with: presenter.model())
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else if indexPath.section == 1 {
            return 350
        } else {
            return 200
        }
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
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
}

//MARK: - BookingViewProtocol

extension BookingViewController: BookingViewProtocol {
    func updateView() {
        tableView.reloadData()
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


