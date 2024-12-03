//
//  Errors.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

enum WeatherError: Error {
    case cityNotFound
}

extension WeatherError {
    var localizedDescription: String {
        switch self {
        case .cityNotFound:
            "City not found. Try another name"
        }
    }
}
