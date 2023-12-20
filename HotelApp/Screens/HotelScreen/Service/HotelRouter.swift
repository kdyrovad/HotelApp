//
//  HotelRouter.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation

enum HotelRouter: Router {
    case hotels
//    case detailCountry(id: String)
    
    var baseUrl: String {
        "https://run.mocky.io/v3"
    }
    
    var path: String {
        switch self {
        case .hotels:
            return "/d144777c-a67f-4e35-867a-cacc3b827473"
//        case .detailCountry(let id):
//            return "/alpha\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .hotels:
            return .get
        }
    }
}
