//
//  Weather+Mock.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

extension WeatherResponse {
    static func stub() -> WeatherResponse {
        
        let JSON = """
        {
          "coord": {
            "lon": -118.2437,
            "lat": 34.0522
          },
          "weather": [
            {
              "id": 701,
              "main": "Mist",
              "description": "mist",
              "icon": "50d"
            }
          ],
          "base": "stations",
          "main": {
            "temp": 297.62,
            "feels_like": 298.16,
            "temp_min": 293.68,
            "temp_max": 300.21,
            "pressure": 1013,
            "humidity": 78,
            "sea_level": 1013,
            "grnd_level": 994
          },
          "visibility": 6437,
          "wind": {
            "speed": 3.6,
            "deg": 140
          },
          "clouds": {
            "all": 40
          },
          "dt": 1725382323,
          "sys": {
            "type": 2,
            "id": 2075946,
            "country": "US",
            "sunrise": 1725370110,
            "sunset": 1725416171
          },
          "timezone": -25200,
          "id": 5368361,
          "name": "Los Angeles",
          "cod": 200
        }
        """
        
        let jsonData = JSON.data(using: .utf8)!
        let weather: WeatherResponse = try! JSONDecoder().decode(WeatherResponse.self, from: jsonData)
        return weather
    }
}
