//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation
import UIKit

// MARK: - WeatherType
enum WeatherType: String, CaseIterable, Codable {
    case Rain
    case Snow
    case Haze
    case Clear
    case Clouds
    case Drizzle
    case Thunderstorm
    
    var title: String {
        return self.rawValue
    }
    
    var imageName: String {
        switch self {
        case .Rain:
            return "rain_gif"
        case .Snow:
            return "snow_gif"
        case .Haze:
            return "cloudy_gif"
        case .Clear:
            return "clear_gif"
        case .Clouds:
            return "cloudy_gif"
        case .Drizzle:
            return "rain_gif"
        case .Thunderstorm:
            return "thunderstorm_gif"
        }
    }
    
    static func with(text: String) -> WeatherType? {
        return self.allCases.first { "\($0)" == text }
    }
}
