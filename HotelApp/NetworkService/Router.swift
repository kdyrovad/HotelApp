//
//  Router.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 16.12.2023.
//

import Foundation

protocol Router {
    typealias Headers = [String: String]
    typealias Parameters = [String: Any]
    typealias Body = [String: Any?]
    
    var baseUrl: String { get }
    var path: String { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
//    var parameters: Parameters { get }
    var body: Body { get }
    
    func request() throws -> URLRequest
}

extension Router {
    var headers: Headers {
        [:]
    }
    
    var body: Body {
        [:]
    }
    
    var httpBody: Data? {
        if body.isEmpty { return nil }
        return try? JSONSerialization.data(withJSONObject: body, options: [])
    }
}

extension Router {
    func request() throws -> URLRequest {
        let urlString = baseUrl + path
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.missingURL
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        
        addHeaders(to: &request)
        
        return request
    }
    
    private func addHeaders(to request: inout URLRequest) {
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

