//
//  WeatherInfo.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

struct WeatherInfoResponse: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
