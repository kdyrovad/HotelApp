//
//  HotelRouter.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation

enum HotelRouter: Router {
    case hotels
    case rooms
    case booking
    
    var baseUrl: String {
        "https://run.mocky.io/v3"
    }
    
    var path: String {
        switch self {
        case .hotels:
            return "/d144777c-a67f-4e35-867a-cacc3b827473"
        case .rooms:
            return "/8b532701-709e-4194-a41c-1a903af00195"
        case .booking:
            return "/63866c74-d593-432c-af8e-f279d1a8d2ff"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .hotels, .rooms, .booking:
            return .get
        }
    }
}
