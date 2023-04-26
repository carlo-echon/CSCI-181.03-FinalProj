//
//  ViewController.swift
//  FinalProj-CSCI-181.03
//
//  Created by Carlo Echon on 4/26/23.
//

import UIKit



class ViewController: UIViewController {
    
    private let viewModel = WeatherViewModel()

    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var MaxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchWeather { [weak self] in
            print("Weather Retrieved, Update UI.")
            DispatchQueue.main.async {
                self?.setUpUI()
            }
        }
    }
    
    private func setUpUI() {
        setUpHeader()
        setUpSubHeader()
    }
    
    private func setUpHeader() {
        temperatureLabel.text = viewModel.temperatureString
        cityLabel.text =
        viewModel.cityString
    }
    
    private func setUpSubHeader() {
        feelsLikeLabel.text = viewModel.feelsLikeString
        minTempLabel.text = viewModel.minTempString
        MaxTempLabel.text = viewModel.maxTempString
        pressureLabel.text = viewModel.pressureString
        humidityLabel.text = viewModel.humidityString
    }

}

