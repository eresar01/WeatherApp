//
//  AppColor.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation
import UIKit

struct AppColors {
    
    // MARK: Background Colors
    struct Background {
        static let `default` = UIColor(light: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), dark: nil)
        static let darkBlue = UIColor(light: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), dark: nil)
        static let lightBlue = UIColor(light: #colorLiteral(red: 0.1497083293, green: 0.4215426465, blue: 0.610017586, alpha: 0.903186116), dark: nil)
    }
    
    // MARK: Text Colors
    struct Text {
        static let white = UIColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: nil)
    }
    
    // MARK: Image Colors
    struct Image {
        static let weatherType = UIColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: nil)
    }
}

public extension UIColor {

    /// Creates a color object that generates its color data dynamically using the specified colors.
    /// - Parameters:
    ///   - light: The color for light mode.
    ///   - dark: The color for dark mode.
    convenience init(light: UIColor, dark: UIColor?) {
        self.init { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return dark ?? light
            }
            return light
        }
    }
}

