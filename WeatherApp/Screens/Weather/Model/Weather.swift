//
//  Weather.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let coord: Coord?
    let weather: [WeatherItem]
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let dt: Int?
    let sys: Sys
    let id: Int?
    let name: String?
    let cod: Int?
    
    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int?
    }
    
    // MARK: - Coord
    struct Coord: Codable {
        let lon, lat: Double?
    }
    
    // MARK: - Main
    struct Main: Codable {
        let temp: Double?
        let pressure, humidity: Int?
        let tempMin, tempMax: Double?
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    // MARK: - Sys
    struct Sys: Codable {
        let type, id: Int?
        let message: Double?
        let country: String?
        let sunrise, sunset: Int?
    }

    // MARK: - Weather
    struct WeatherItem: Codable {
        let id: Int?
        let main: WeatherType?
        let description, icon: String?
    }
    
    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
    }
}
