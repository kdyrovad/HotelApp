//
//  HotelResponce.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation
import UIKit

struct Hotel: Decodable {
    let idd: Int
    let name: String
    let adress: String
    let price: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: HotelInfo
    
    enum CodingKeys: String, CodingKey {
        case idd = "id"
        case name, adress, rating
        case price = "minimal_price"
        case priceForIt = "price_for_it"
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"

    }
}

struct HotelInfo: Decodable {
    let description: String
    let peculiarities: [String]
}



