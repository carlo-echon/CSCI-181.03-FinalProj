//
//  WeatherViewModel.swift
//  FinalProj-CSCI-181.03
//
//  Created by Carlo Echon on 4/26/23.
//

import UIKit

class WeatherViewModel {
    let apiController = APIController()
    
    var weather: Weather?
    
    //Header Strings
    var temperatureString: String {
        return String(format: "%.2f", (weather?.temp ?? 0).kelvinToFarenheit) + " °F"
    }
    
    var cityString: String {
        return String(weather?.name ?? "Empty")
    }
    
    //Subheader Strings
    var feelsLikeString: String {
        return String(format: "%.2f", (weather?.feelsLike ?? 0).kelvinToFarenheit) + " °F"
    }
    
    var minTempString: String {
        return String(format: "%.2f", (weather?.minTemperature ?? 0).kelvinToFarenheit) + " °F"
    }
    
    var maxTempString: String {
        return String(format: "%.2f", (weather?.maxTemperature ?? 0).kelvinToFarenheit) + " °F"
    }
    
    var pressureString: String {
        return String(format: "%.1f", (weather?.pressure ?? 0))
    }
    
    var humidityString: String {
        return String(format: "%.1f", (weather?.humidity ?? 0))
    }




    
    func fetchWeather(latitude: Double, longitude: Double, _ completion: @escaping(() -> Void)){
        apiController.fetchWeather(latitude: latitude, longitude: longitude) { weather in
            self.weather = weather
            completion()
        }
    }


}
