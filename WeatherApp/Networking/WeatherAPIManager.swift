//
//  API.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//
import RxSwift
import Foundation

struct APIConstants {
    static let appId = "5deca2f99f97d972562a33188d696b4a"
}

enum WeatherSearchRequest: APIRequest {
    case search(_ text: String)
        
        var endpoint: String{
            switch self {
            case .search(let text):
                return "/weather?q=\(text)&appid=\(APIConstants.appId)"
            }
        }
        var httpMethod: HTTPMethod {
            switch self {
            case .search:
                return .get
            }
        }
        var parameters: [String: Any] {
            switch self {
            case .search:
                return [:]
            }
        }
        
        var headers: [String : String] {
            switch self {
            case .search:
                return [:]
            }
        }
}

enum ForecastSearchRequest: APIRequest {
    case search(_ text: String)
        var endpoint: String{
            switch self {
            case .search(let text):
                return "/forecast?q=\(text)&appid=\(APIConstants.appId)"
            }
        }
        var httpMethod: HTTPMethod {
            switch self {
            case .search:
                return .get
            }
        }
        var parameters: [String: Any] {
            switch self {
            case .search:
                return [:]
            }
        }
        
        var headers: [String : String] {
            switch self {
            case .search:
                return [:]
            }
        }
}


protocol MockURL: URLProtocol { }

struct WeatherAPIManager: WeatherAPI {
    private let environment: APIEnvironment
    
    init(session: URLSession = .shared, environment: APIEnvironment) {
        self.environment = environment
    }
    
    func requestData<T: Decodable>(request: APIRequest) -> Observable<T>{
        let URLString = environment.baseURL(endpoint: request.endpoint)
        guard let url = URL(string: URLString) else {
            preconditionFailure("Can't create url for query")
        }
        var requestURL = URLRequest(url: url)
        
        switch request.httpMethod {
        case .post:
            for method in request.headers {
                requestURL.setValue(method.value, forHTTPHeaderField: method.key)
            }
            requestURL.httpMethod = request.httpMethod.rawValue
            requestURL.httpBody = try? JSONSerialization.data(withJSONObject: request.parameters, options: .prettyPrinted)
        case .get:
            break
        }
        
        return URLSession.shared.rx.data(request: requestURL)
            .map {
                try JSONDecoder().decode(T.self, from: $0)
            }
            .observe(on: MainScheduler.asyncInstance)
    }
}
