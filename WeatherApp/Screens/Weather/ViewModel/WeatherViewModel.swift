//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation

class WeatherViewModel {
    
    // MARK: - Properties
    
    private var weatherService: WeatherServiceProtocol
    private var cityName: String
    
    var setupPageData: ((WeatherPageModel) -> Void)?
    var error: ((Alert.Error) -> Void)?
    
    // MARK: Object lifecycle
    
    init(service: WeatherServiceProtocol = WeatherService(), cityName: String) {
        weatherService = service
        self.cityName = cityName
    }
    
    // MARK: Get weather data
    // network service
    
    func getWeatherData() {
        weatherService.getWeather(cityName: cityName) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let items):
                if !items.weather.isEmpty,
                   let type = items.weather[0].main,
                   let temp = items.main.temp {
                    //   273.15 calvin = 0˚C
                    let celsius = Int(temp - 273.15)
                    let model = WeatherPageModel(cityName: self.cityName,
                                                 weatherType: type,
                                                 temperature: celsius)
                    DispatchQueue.global(qos: .background).async {
                        WeatherCoreDataManager.shared.save(model)
                    }
                    self.setupPageData?(model)
                    return
                }
                self.error?(self.errorData(ServiceError.notValid))
            case .failure(let error):
                if error == ServiceError.internetConnection {
                    self.loadDBData(name: self.cityName)
                    return
                }
                self.error?(self.errorData(error))
            }
        }
    }
    
    // MARK: Get weather data
    // DB service
    
    private func loadDBData(name: String) {
        let dbManager = WeatherCoreDataManager.shared
        if let item = dbManager.getWeather(name: name),
           let type = item.type,
           let weatherType = WeatherType.with(text: type) {
            let temp = Int(item.temp)
            let model = WeatherPageModel(cityName: name,
                                         weatherType: weatherType,
                                         temperature: temp)
            self.setupPageData?(model)
        } else {
            self.error?(self.errorData(ServiceError.internetConnection))
        }
    }
    
    // MARK: Error
    
    func errorData(_ error: ServiceError) -> Alert.Error {
        let title = "Error"
        let message = error.localizedDescription
        let firstActionTitle = "reload"
        let secondActionTitle = "dismiss"
        return Alert.Error(title: title,
                           message: message,
                           firstActionTitle: firstActionTitle,
                           secondActionTitle: secondActionTitle)
    }
    
}
