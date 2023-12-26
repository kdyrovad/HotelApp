//
//  RoomsPresenter.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 20.12.2023.
//

import Foundation

protocol RoomsViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol RoomsPresenterProtocol {
    var view: RoomsViewProtocol? { get set }
    
    func loadView(completion: @escaping () -> Void)
    func model() -> RoomsModelProtocol
}

final class RoomsPresenter: RoomsPresenterProtocol {
    
    private let service: RoomsServiceProtocol
    private var rooms: RoomsModelProtocol?
    
    init(service: RoomsServiceProtocol) {
        self.service = service
    }
    
    weak var view: RoomsViewProtocol?
    
    func model() -> RoomsModelProtocol {
        return rooms!
    }
    
    func loadView(completion: @escaping () -> Void) {
        view?.updateView(withLoader: true)
        
        service.getRooms { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let rooms):
                self?.rooms = rooms
                self?.view?.updateView()
                completion()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
                print((error.localizedDescription))
            }
        }
    }
    
}



