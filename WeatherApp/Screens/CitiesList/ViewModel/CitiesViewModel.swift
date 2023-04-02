//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation
import UIKit

class CitiesViewModel {
    
    // MARK: - Clousers
    var reloadCollectionView: (() -> Void)?
    var cities = Cities()
    
    var cityCellViewModels = [CityCellViewModel]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    // MARK: Get cities
    
    func getCities() {
        cities = City.allCases
        var cvm = [CityCellViewModel]()
        for value in cities {
            cvm.append(createCellModel(city: value))
        }
        cityCellViewModels = cvm
    }
    
    // MARK: Create Cell Model
    
    func createCellModel(city: City) -> CityCellViewModel {
        let name = city.rawValue

        return CityCellViewModel(cityName: name)
    }

    func getCellViewModel(at indexPath: IndexPath) -> CityCellViewModel {
        return cityCellViewModels[indexPath.row]
    }
    
    func openWeatherVC(target: UIViewController, cityName: String) {
        let weatherViewModel = WeatherViewModel(cityName: cityName)
        let vc = WeatherViewController(viewModel: weatherViewModel)
        target.present(vc, animated: true)
    }
    
    func selectItem(target: UIViewController, at indexPath: IndexPath) {
        let cityName = cityCellViewModels[indexPath.row].cityName
        openWeatherVC(target: target, cityName: cityName)
    }
}
