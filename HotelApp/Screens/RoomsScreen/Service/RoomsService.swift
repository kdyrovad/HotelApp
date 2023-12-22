//
//  RoomsService.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 20.12.2023.
//

import Foundation

protocol RoomsServiceProtocol {
    func getRooms(completion: @escaping (Result<RoomsModelProtocol, NetworkError>) -> Void)
}

final class RoomsService: RoomsServiceProtocol {
    
    func getRooms(completion: @escaping (Result<RoomsModelProtocol, NetworkError>) -> Void) {
        print("Calling getRooms")
        client.execute(with: HotelRouter.rooms) { [weak self] (result: Result<Room, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let rooms):
                completion(.success(self.roomsModels(for: rooms)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func roomsModels(for rooms: Room) -> RoomsModelProtocol {
        RoomsModel(rooms: rooms)
    }
    
    private let client: NetworkService
    
    private var rooms: RoomsModelProtocol?
    
    init(client: NetworkService) {
        self.client = client
    }
}


