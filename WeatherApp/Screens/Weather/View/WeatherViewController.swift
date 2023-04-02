//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // MARK: - Properties
    
    let viewModel: WeatherViewModel
    lazy var alertViewModel = { AlertViewModel() }()
    
    // MARK: Object lifecycle
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WeatherViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
    }
    
    // MARK: Setup
    
    func setupView() {
        view.backgroundColor = AppColors.Background.default
        cityName.textColor = AppColors.Text.white
        temperature.textColor = AppColors.Text.white
        weatherType.textColor = AppColors.Text.white

        cityName.font = UIFont.systemFont(ofSize: Constants.cityNameFontSize)
        temperature.font = UIFont.systemFont(ofSize: Constants.temperatureFontSize)
        weatherType.font = UIFont.systemFont(ofSize: Constants.weatherTypeFontSize)
    }
    
    func configure(item: WeatherPageModel) {
        cityName.text = item.cityName
        weatherType.text = item.weatherType.title
        backgroundImage.loadGif(name: item.weatherType.imageName)
        backgroundImage.alpha = Constants.backgroundAlphaStart
        UIView.animate(withDuration: Constants.animateDuration, delay: Constants.animateDelay) {
            self.backgroundImage.alpha = Constants.backgroundAlphaEnd
        }
        temperature.text = String(item.temperature) + "°"
    }
    
    func initViewModel() {
        // Get Weather data
        viewModel.getWeatherData()
        
        // setup page data
        viewModel.setupPageData = { [weak self] item in
            DispatchQueue.main.async {
                guard let self else { return }
                self.configure(item: item)
            }
        }
        
        viewModel.error = { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.alertViewModel.simpleAlert(self,
                                                title: error.title,
                                                message: error.message,
                                                firstActionTitle: error.firstActionTitle,
                                                secondActionTitle: error.secondActionTitle) {
                    self.viewModel.getWeatherData()
                } completionSecond: {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}

// MARK: Constants
extension WeatherViewController {
    struct Constants {
        static var cityNameFontSize: CGFloat = 50
        static var temperatureFontSize: CGFloat = 100
        static var weatherTypeFontSize: CGFloat = 30
        static var backgroundAlphaStart: CGFloat = 0
        static var backgroundAlphaEnd: CGFloat = 1
        static var animateDuration: CGFloat = 1
        static var animateDelay: CGFloat = 0.5
    }
}
