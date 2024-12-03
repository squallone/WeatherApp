//
//  KelvinTempertureConverter.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

struct KelvinTempertureConverter {
    let scale: Temperture.Scale
      
    func convert(temperture: Double) -> Double {
        switch scale {
        case .farenheit:
            return (temperture - 273.15) * 9/5 + 32
        case .kelvin:
            return temperture
        case .celsius:
            return temperture - 273.15
        }
    }
}
