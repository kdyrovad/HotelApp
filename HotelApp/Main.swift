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
    
    func roomsService() -> RoomsServiceProtocol {
        RoomsService(client: network)
    }
    
    func bookingService() -> BookingServiceProtocol {
        BookingService(client: network)
    }
    
    func hotelScreen() -> UIViewController {
        let presenter = HotelPresenter(service: hotelService())
        let view = HotelViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func navController() -> UINavigationController {
        return UINavigationController(rootViewController: hotelScreen())
    }
    
    func roomsScreen() -> UIViewController {
        let presenter = RoomsPresenter(service: roomsService())
        let roomsVC = RoomsViewController(presenter: presenter)
        presenter.view = roomsVC
        
        return roomsVC
    }
    
    func bookingScreen() -> UIViewController {
        let presenter = BookingPresenter(service: bookingService())
        let bookingVC = BookingViewController(presenter: presenter)
        return bookingVC
    }
    
    func successScreen() -> UIViewController {
        let vc = SuccessViewController()
        return vc
    }
}

