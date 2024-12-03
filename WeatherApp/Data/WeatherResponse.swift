//
//  Coordinates.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//

import Foundation

struct ForecastList: Decodable {
    let visibility: Int?
}

struct ForecastResponse: Decodable {
    let errorMessage: String?
    let errorCode: Int?
    let forecast: [ForecastList]?
    
    enum CodingKeys: String, CodingKey {
        case message
        case cod
        case list
    }
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try? values.decode(Int.self, forKey: .cod)
        errorMessage = try? values.decode(String.self, forKey: .message)
        forecast = try? values.decode([ForecastList].self, forKey: .list)
    }
}


struct WeatherResponse: Decodable {
    let errorMessage: String?
    let city: String?
    let coordinates: CoordinatesResponse?
    let weatherInfo: [WeatherInfoResponse]?
    let mainInfo: MainResponse?
    let wind: Wind?

    enum CodingKeys: String, CodingKey {
        case message
        case name
        case coord
        case weather
        case main
        case wind
        case list
    }
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(String.self, forKey: .name)
        coordinates = try values.decode(CoordinatesResponse.self, forKey: .coord)
        weatherInfo = try values.decode([WeatherInfoResponse].self, forKey: .weather)
        mainInfo = try values.decode(MainResponse.self, forKey: .main)
        wind = try values.decode(Wind.self, forKey: .wind)
        errorMessage = try? values.decode(String.self, forKey: .message)
    }
}

extension WeatherResponse {
    func toEntity() -> Weather {
        Weather(
            city: City(
                name: city ?? "",
                latitude: coordinates?.latitude ?? 0,
                longitude: coordinates?.longitude ?? 0
            ),
            pressure: mainInfo?.pressure ?? 0,
            humidity: mainInfo?.humidity ?? 0,
            wind: wind?.speed ?? 0,
            temperture: Temperture(
                kelvin: mainInfo?.kelvin ?? 0,
                min: mainInfo?.minTemperture ?? 0, 
                max: mainInfo?.maxTemperture ?? 0
            ),
            mainDescription: weatherInfo?.first?.main ?? "",
            description: weatherInfo?.first?.description ?? "",
            icon: weatherInfo?.first?.icon ?? ""
        )
    }
}

extension ForecastResponse {
    func toEntity() -> Forecast {
        var forecastListData: [ForecastItem] = []
        if let list = forecast {
            list.forEach { item in
                forecastListData.append(ForecastItem(visibility: item.visibility ?? 0))
            }
        }
        
        return Forecast(item: forecastListData)
    }
}



struct Wind: Decodable {
    let speed: Double
}
