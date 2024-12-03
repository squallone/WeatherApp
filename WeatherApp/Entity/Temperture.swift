//
//  Temperture.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

struct Temperture {
    enum Scale {
        case celsius
        case farenheit
        case kelvin
    }
    
    let kelvin: Double
    let min: Double
    let max: Double
    
    func convert(scale: Temperture.Scale) -> Double {
        let converter = KelvinTempertureConverter(scale: scale)
        return converter.convert(temperture: kelvin)
    }
}
