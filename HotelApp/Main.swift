//
//  Main.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation
import UIKit

final class Main {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    static let shared: Main = .init()
    
    func networkService() -> NetworkService {
        network
    }
    
    func hotelService() -> HotelServiceProtocol {
        HotelService(client: network)
    }
    
    func hotelScreen() -> UIViewController {
        let presenter = HotelPresenter(service: hotelService())
        let view = HotelViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
//    func detailsScreen(for model: CountryModelProtocol) -> DetailViewController {
//        let presenter = DetailPresenter(service: countryService(), model: model)
//        let detailVC = DetailViewController(presenter: presenter)
//        return detailVC
//    }
    
    func navController() -> UINavigationController {
        return UINavigationController(rootViewController: hotelScreen())
    }
}

