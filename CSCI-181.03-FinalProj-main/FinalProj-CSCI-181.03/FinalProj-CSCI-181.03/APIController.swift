//
//  APIController.swift
//  FinalProj-CSCI-181.03
//
//  Created by Carlo Echon on 4/26/23.
//

import Foundation

//API Calls
struct APIController{
    private static var baseURL = "api.openweathermap.org"
    private static let apiKey = "1152cff6cec805798d0e733b72df2bcd"
    
    enum Endpoints{
        case location(path: String = "/data/2.5/weather", lat: Double, lon: Double)
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseURL
            components.path = path
            components.queryItems = queryParameters
            
            return components.url
        }
        
        private var path: String{
            switch self{
            case .location(let path, _, _):
                return path
            }
        }
        
        private var queryParameters: [URLQueryItem] {
            var queryParameters = [URLQueryItem]()
            switch self{
            case .location(_, let lat, let lon):
                queryParameters.append(URLQueryItem(name: "lat", value: String(lat)))
                queryParameters.append(URLQueryItem(name: "lon", value: String(lon)))
            }
            queryParameters.append(URLQueryItem(name: "appid", value: apiKey))
            
            return queryParameters
        }
    }


    
    //5128581 is New York city ID.
    func fetchWeather(latitude: Double, longitude: Double, _ completion: @escaping((Weather) -> Void)) {
        if let url = Endpoints.location(lat: latitude, lon: longitude).url {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error{
                    print("Error in API Call", error)
                }
                
                if let data = data{
                    do {
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        completion(weather)
                    } catch let error {
                        print("Failed to Decode Object", error)
                    }
                }
            }.resume()
        }
    }

}
