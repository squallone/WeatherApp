//
//  SearchUseCase.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import RxSwift

protocol SearchWeatherUseCase {
    func execute(searchText: String) -> Observable<Weather>
}

struct SearchWeather: SearchWeatherUseCase {
    
    private let weatherAPI: WeatherAPI
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    func execute(searchText text: String) -> Observable<Weather> {
        let response: Observable<WeatherResponse> = weatherAPI
            .requestData(request: WeatherSearchRequest.search(text))
        return response.map { $0.toEntity() }.catch { error in
            return .error(WeatherError.cityNotFound)
        }
    }
    
    private func checkIfError() -> Observable<Weather> {
        return .error(WeatherError.cityNotFound)
    }
}
