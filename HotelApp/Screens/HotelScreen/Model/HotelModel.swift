//
//  HotelModel.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation
import UIKit

protocol HotelModelProtocol {
    var name: String { get }
    var adress: String { get }
    var price: String { get }
    var priceForIt: String { get }
    var rating: String { get }
    var ratingName: String { get }
    var imageUrls: [String] { get }
    var hotelDescription: String { get }
    var hotelPeculiraties: [String] { get }
}

final class HotelModel: HotelModelProtocol {
    
    private let hotel: Hotel
    
    init(hotel: Hotel) {
        self.hotel = hotel
    }
    
    var name: String {
        hotel.name
    }
    
    var adress: String {
        hotel.adress
    }
    
    var price: String {
        "от \(hotel.price) ₽"
    }
    
    var priceForIt: String {
        hotel.priceForIt.lowercased()
    }
    
    var rating: String {
        "\(hotel.rating) "
    }
    
    var ratingName: String {
        hotel.ratingName
    }
    
    var imageUrls: [String] {
        hotel.imageUrls
    }
    
    var hotelDescription: String {
        hotel.aboutTheHotel.description
    }
    
    var hotelPeculiraties: [String] {
        hotel.aboutTheHotel.peculiarities
    }
}

