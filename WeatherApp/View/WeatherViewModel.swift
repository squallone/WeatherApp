//
//  WeatherViewModel.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import RxCocoa
import RxRelay
import RxSwift

protocol WeatherViewModelInputs {
    var searchTextRelay: BehaviorRelay<String> { get }
    func search()
    func forecast()
}

protocol WeatherViewModelOutputs {
    var error: PublishSubject<Error> { get }
    var weatherData: PublishSubject<Weather> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol WatherViewModeling {
    var inputs: WeatherViewModelInputs { get }
    var outputs: WeatherViewModelOutputs { get }
}

final class WeatherViewModel: WatherViewModeling, WeatherViewModelInputs, WeatherViewModelOutputs {
    var inputs: WeatherViewModelInputs { return self }
    var outputs: WeatherViewModelOutputs { return self }
    let useCase: SearchWeatherUseCase
    let forecastUseCase: SearchForecastUseCase

    // Inputs
    let searchTextRelay = BehaviorRelay<String>(value: "")
    // Outputs
    let error: PublishSubject<Error>
    let weatherData: PublishSubject<Weather>

    let isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: Private
    private let disposeBag = DisposeBag()
    
    init(useCase: SearchWeatherUseCase, forecastUsecase: SearchForecastUseCase) {
        self.useCase = useCase
        self.forecastUseCase = forecastUsecase
        error = PublishSubject()
        weatherData = PublishSubject()
    }
    
    func search() {
        isLoading.accept(true)
        useCase.execute(searchText: searchTextRelay.value)
            .subscribe(onNext: { [weak self] weather in
                guard let self else { return }
                self.isLoading.accept(false)
                self.weatherData.onNext(weather)
            }, onError: { [weak self] error in
                guard let self else { return }
                self.isLoading.accept(false)
                self.error.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    func forecast() {
        forecastUseCase
            .execute(searchText: searchTextRelay.value)
            .subscribe { forecast in
            print(forecast)
        }.disposed(by: disposeBag)
    }
}

