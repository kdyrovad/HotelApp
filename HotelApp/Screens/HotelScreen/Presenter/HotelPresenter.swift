//
//  HotelPresenter.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation

protocol HotelViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol HotelPresenterProtocol {
    var view: HotelViewProtocol? { get set }
//    var itemsCount: Int { get }
    
//    var groupedElements: [String: [CountryModel]] { get }
    
    func loadView(completion: @escaping () -> Void)
    func model() -> HotelModelProtocol
}

final class HotelPresenter: HotelPresenterProtocol {
    
    private let service: HotelServiceProtocol
    private var hotels: HotelModelProtocol?
    
    init(service: HotelServiceProtocol) {
        self.service = service
    }
    
    weak var view: HotelViewProtocol?
    
//    var itemsCount: Int {
//        hotels.count
//    }
    
    func model() -> HotelModelProtocol {
        hotels!
    }
    
    func loadView(completion: @escaping () -> Void) {
        print("start loadView")
        view?.updateView(withLoader: true)
        
        service.getHotels { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let hotels):
                self?.hotels = hotels
                self?.view?.updateView()
                print("loadView success")
                completion()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
                print("loadView error")
                print((error.localizedDescription))
            }
            print("end loadView")
        }
    }
    
}

