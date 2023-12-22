//
//  RoomsResponce.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 20.12.2023.
//

import Foundation
import UIKit

struct Room: Decodable {
    let rooms: [RoomDetail]
}

struct RoomDetail: Decodable {
    let idd: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case idd = "id"
        case name, price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}
