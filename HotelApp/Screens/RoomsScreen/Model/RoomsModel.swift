//
//  RoomsModel.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 20.12.2023.
//

import Foundation
import UIKit

protocol RoomsModelProtocol {
    var name: String { get }
    var roomsCount: Int { get }
    var peculiarities: [String] { get }
    var imageUrls: [String] { get }
    var price: String { get }
    var pricePer: String { get }
//    var roomId: Int { get }
    static var roomIndex: Int { get }
}

final class RoomsModel: RoomsModelProtocol {
    
    private let rooms: Room
    static var roomIndex: Int = 0
    
    init(rooms: Room) {
        self.rooms = rooms
    }
    
    var roomsCount: Int {
        rooms.rooms.count
    }
    
    var peculiarities: [String] {
        rooms.rooms[RoomsModel.roomIndex].peculiarities
    }
    
    var imageUrls: [String] {
        rooms.rooms[RoomsModel.roomIndex].imageUrls
    }
    
    var price : String {
        "\(rooms.rooms[RoomsModel.roomIndex].price) ₽"
    }
    
    var pricePer: String {
        rooms.rooms[RoomsModel.roomIndex].pricePer
    }
    
//    var roomId: Int {
//        rooms.roo
//    }
    
    var name: String {
        return rooms.rooms[RoomsModel.roomIndex].name
    }
    
}



