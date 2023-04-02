//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation

// MARK: WeatherServiceProtocol
protocol WeatherServiceProtocol {
    func getWeather(cityName: String, completion: @escaping (Result<Weather, ServiceError>) -> Void)
}


class WeatherService: WeatherServiceProtocol {
    
    // MARK: - Const properties
    private let URL_WEATHER = "https://api.openweathermap.org/data/2.5/weather?"
    private let API_KEY = "&appid=33aaadc8c64a8798fe3e5994410e3f47"
    
    
    // MARK: - get Weather API coll
    func getWeather(cityName: String, completion: @escaping (Result<Weather, ServiceError>) -> Void) {
        let query = "q=\(cityName)"
        guard let url = URL(string: URL_WEATHER + query + API_KEY) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let items = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(items))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                    completion(.failure(ServiceError.dataCorrupted))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("### Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(ServiceError.keyNotFound))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("*** Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(ServiceError.valueNotFound))
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(ServiceError.typeMismatch))
                } catch(let error) {
                    print("error: ", error)
                    completion(.failure(error as! ServiceError))
                }
            } else if let error {
                if (error as! URLError).code == URLError.notConnectedToInternet {
                    completion(.failure(ServiceError.internetConnection))
                } else {
                    completion(.failure(ServiceError.request(error: error)))
                }
            }
        }
        .resume()
    }
}

//MARK: Error
public enum ServiceError: Error, Equatable {
    
    case internetConnection
    case request(error: Error)
    case notValid
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
    

    public var localizedDescription: String {
        switch self {
        case .internetConnection:
            return "No internet connection"
        case .request(let error):
            return "HTTPS Request Failed \(error)"
        case .dataCorrupted:
            return "data Corrupted"
        case .keyNotFound:
            return "key Not Found"
        case .valueNotFound:
            return "value Not Found"
        case .typeMismatch:
            return "type Mismatch"
        case .notValid:
            return "not valid data"
        }
    }
    
    public static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.internetConnection, .internetConnection):
            return true
        case (.request, .request):
            return true
        case (.dataCorrupted, .dataCorrupted):
            return true
        case (.valueNotFound, .valueNotFound):
            return true
        case (.typeMismatch, .typeMismatch):
            return true
        case (.notValid, .notValid):
            return true
        case (.keyNotFound, .keyNotFound):
            return true
        case (.internetConnection, _), (.request, _), (.dataCorrupted, _), (.valueNotFound, _), (.typeMismatch, _), (.notValid, _), (.keyNotFound, _):
            return false
        }
    }
}
