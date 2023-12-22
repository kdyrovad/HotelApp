//
//  BookingPresenter.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//

import Foundation

protocol BookingViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol BookingPresenterProtocol {
    var view: BookingViewProtocol? { get set }
//    var itemsCount: Int { get }
    
//    var groupedElements: [String: [CountryModel]] { get }
    
    func loadView(completion: @escaping () -> Void)
    func model() -> BookingModelProtocol
}

final class BookingPresenter: BookingPresenterProtocol {
    
    private let service: BookingServiceProtocol
    private var bookings: BookingModelProtocol?
    
    init(service: BookingServiceProtocol) {
        self.service = service
    }
    
    weak var view: BookingViewProtocol?
    
//    var itemsCount: Int {
//        hotels.count
//    }
    
    func model() -> BookingModelProtocol {
        bookings!
    }
    
    func loadView(completion: @escaping () -> Void) {
        print("start loadView")
        view?.updateView(withLoader: true)
        
        service.getBooking { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let bookings):
                self?.bookings = bookings
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
