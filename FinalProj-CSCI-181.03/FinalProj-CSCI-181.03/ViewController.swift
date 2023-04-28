//
//  ViewController.swift
//  FinalProj-CSCI-181.03
//
//  Created by Carlo Echon on 4/26/23.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
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
        locationManager.requestWhenInUseAuthorization()
//        viewModel.fetchWeather(latitude: 14.637670, longitude: 121.077367) { [weak self] in
//            print("Weather Retrieved, Update UI.")
//            DispatchQueue.main.async {
//                self?.setUpUI()
//            }
//        }
        
        if CLLocationManager.locationServicesEnabled() {
                   locationManager.delegate = self
                   locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
                   locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
            viewModel.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] in
                print("Weather Retrieved, Update UI.")
                DispatchQueue.main.async {
                    self?.setUpUI()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",message: "In order to deliver pizza we need your location", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
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

