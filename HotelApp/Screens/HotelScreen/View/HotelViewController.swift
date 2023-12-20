//
//  HotelViewController.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 15.12.2023.
//

import UIKit
import SnapKit

class HotelViewController: UIViewController {
    
    private var presenter: HotelPresenterProtocol
    
    //MARK: - Init
    
    init(presenter: HotelPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(hexString: "#F6F6F9")
        navigationItem.title = "Отель"
        print("start viewWillAppear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("start viewDidLoad")
        presenter.loadView { [weak self] in
            self?.tableView.reloadData()
            self?.setUpViews()
        }
    }
    
    //MARK: - Views
    
    private lazy var footerViewOfTable: UIView = {
        let vieww = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        vieww.backgroundColor = .blue
        return vieww
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "secondCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
//        tableView.tableFooterView = footerViewOfTable
        tableView.backgroundColor = UIColor(hexString: "#F6F6F9")
        return tableView
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        view.addSubview(tableView)
        setContraints()
    }
}

//MARK: - Constraints

extension HotelViewController {
    
    private func setContraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HotelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
                    return UITableViewCell()
            }
            cell.backgroundColor = .white
            cell.configure(with: presenter.model())
            cell.layer.cornerRadius = 12
            tableView.isScrollEnabled = true
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? DetailTableViewCell else {
                    return UITableViewCell()
            }
            cell.backgroundColor = .white
            cell.configure(with: presenter.model())
            cell.layer.cornerRadius = 12
            tableView.isScrollEnabled = true
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? ButtonTableViewCell else {
                return UITableViewCell()
            }
//            tableView.isScrollEnabled = false
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 486
        } else if indexPath.section == 1 {
            return 486
        } else {
            return 88
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
    
    
    
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == numberOfSections(in: tableView) - 1 {
//            // Устанавливаем высоту футера после последнего раздела
//            return 20.0 // Задайте желаемую высоту между последним разделом и футером
//        } else {
//            return 0.0 // Если это не последний раздел, высота футера будет 0
//        }
//    }
//
//    // Настройка содержимого футера
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == numberOfSections(in: tableView) - 1 {
//            // Настройка содержимого футера только для последнего раздела
//            let footerView = UIView()
//            footerView.backgroundColor = .blue // Цвет фона футера
//
//            // Вы можете добавить другие представления и элементы управления внутри футера
//            let label = UILabel()
//            label.text = "Ваш футер"
//            label.textColor = .white
//            footerView.addSubview(label)
//
//            return footerView
//        } else {
//            return nil // Если это не последний раздел, возвращаем nil для отсутствия футера
//        }
//    }

}


//MARK: - HotelViewProtocol

extension HotelViewController: HotelViewProtocol {
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



//MARK: - Extension UIColor

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
