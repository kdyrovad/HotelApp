//
//  BookingModel.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//


import Foundation
import UIKit

protocol BookingModelProtocol {
    var hotelName: String { get }
    var adress: String { get }
    var rating: String { get }
    var detailData: [String] { get }
}

final class BookingModel: BookingModelProtocol {
    
    private let booking: Bookingg
    
    init(booking: Bookingg) {
        self.booking = booking
    }
    
    var hotelName: String {
        booking.hotelName
    }
    
    var adress: String {
        booking.hotelAdress
    }
    
    var rating: String {
        "\(booking.horating) \(booking.ratingName)"
    }
    
    var detailData: [String] {
        [booking.departure, booking.arrivalCountry, "\(booking.tourDateStart) - \(booking.tourDateStop)", "\(booking.numberOfNights) ночей", booking.hotelName, booking.room, booking.nutrition]
    }
}


