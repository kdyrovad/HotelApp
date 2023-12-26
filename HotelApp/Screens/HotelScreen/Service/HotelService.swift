//
//  HotelService.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation

protocol HotelServiceProtocol {
    func getHotels(completion: @escaping (Result<HotelModelProtocol, NetworkError>) -> Void)
}

final class HotelService: HotelServiceProtocol {
    
    func getHotels(completion: @escaping (Result<HotelModelProtocol, NetworkError>) -> Void) {
        client.execute(with: HotelRouter.hotels) { [weak self] (result: Result<Hotel, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let hotels):
                completion(.success(self.hotelModels(for: hotels)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func hotelModels(for hotels: Hotel) -> HotelModelProtocol {
        HotelModel(hotel: hotels)
    }
    
    private let client: NetworkService
    
    private var hotels: HotelModelProtocol?
    
    init(client: NetworkService) {
        self.client = client
    }
}
