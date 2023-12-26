//
//  BookingService.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//


import Foundation

protocol BookingServiceProtocol {
    func getBooking(completion: @escaping (Result<BookingModelProtocol, NetworkError>) -> Void)
}

final class BookingService: BookingServiceProtocol {
    
    func getBooking(completion: @escaping (Result<BookingModelProtocol, NetworkError>) -> Void) {
        client.execute(with: HotelRouter.booking) { [weak self] (result: Result<Bookingg, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let bookings):
                completion(.success(self.bookingModels(for: bookings)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func bookingModels(for bookings: Bookingg) -> BookingModelProtocol {
        BookingModel(booking: bookings)
    }
    
    private let client: NetworkService
    
    private var bookings: BookingModelProtocol?
    
    init(client: NetworkService) {
        self.client = client
    }
}

