//
//  SearchForecastUseCase.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 25/11/24.
//

import RxSwift

protocol SearchForecastUseCase {
    func execute(searchText: String) -> Observable<Forecast>
}

struct SearchForecast: SearchForecastUseCase {
    
    private let weatherAPI: WeatherAPI
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    func execute(searchText text: String) -> Observable<Forecast> {
        let response: Observable<ForecastResponse> = weatherAPI
            .requestData(request: ForecastSearchRequest.search(text))
        return response.map {
            $0.toEntity()
        }.catch { error in
            return .error(WeatherError.cityNotFound)
        }
    }
}
