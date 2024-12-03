//
//  MainInfo.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

struct MainResponse: Decodable {
    let kelvin: Double
    let minTemperture: Double
    let maxTemperture: Double
    let humidity: Int
    let pressure: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case temp_min
        case temp_max
        case humidity
        case pressure

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kelvin = try values.decode(Double.self, forKey: .temp)
        minTemperture = try values.decode(Double.self, forKey: .temp_min)
        maxTemperture = try values.decode(Double.self, forKey: .temp_max)
        pressure = try values.decode(Int.self, forKey: .pressure)
        humidity = try values.decode(Int.self, forKey: .humidity)

    }
}
