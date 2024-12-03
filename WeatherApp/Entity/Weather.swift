//
//  Weather.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

struct Weather {
    let city: City
    let pressure: Int
    let humidity: Int
    let wind: Double
    let temperture: Temperture
    let mainDescription: String
    let description: String
    let icon: String
}


struct Forecast {
    let item: [ForecastItem]
}

struct ForecastItem {
    let visibility: Int
}
