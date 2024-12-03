//
//  WeatherManager.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//

import Foundation
import RxSwift

protocol WeatherAPI {
    func requestData<T: Decodable>(request: APIRequest) -> Observable<T>
}
