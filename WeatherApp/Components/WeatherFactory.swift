//
//  WeatherFactory.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import Foundation

struct WeatherFactory {
    static func create() -> WeatherViewController {
        let environment = APIEnvironment(
            port: "",
            procotol: "https://",
            host: "api.openweathermap.org/data/2.5",
            path: ""
        )
        let api = WeatherAPIManager(environment: environment)
        let useCase = SearchWeather(weatherAPI: api)
        let foreCastUsecase = SearchForecast(weatherAPI: api)
        let viewModel = WeatherViewModel(useCase: useCase, forecastUsecase: foreCastUsecase)
        let viewController = WeatherViewController(viewModel: viewModel)
        return viewController
    }
}
