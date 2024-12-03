//
//  Networking.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol APIRequest {
    var endpoint: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
}

struct APIEnvironment {
    var port: String
    var procotol: String
    var host: String
    var path: String
    
    func baseURL(endpoint: String) -> String {
        return  procotol + port + host + path + endpoint
    }
}
