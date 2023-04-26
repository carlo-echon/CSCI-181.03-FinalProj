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
        case cityID(path: String = "/data/2.5/weather", id: Int)
        
        var URL: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = baseURL
            components.path = path
            components.queryItems = queryParameters
            
            return components.url
        }
        
        private var path: String{
            switch self{
            case .cityID(let path, _):
                return path
            }
        }
        
        private var queryParameters: [URLQueryItem] {
            var queryParameters = [URLQueryItem]()
            switch self{
            case .cityID(_, let id):
                queryParameters.append(URLQueryItem(name: "id", value: String(id)))
            }
            queryParameters.append(URLQueryItem(name: "appid", value: apiKey))
            
            return queryParameters
        }
    }
    
    //5128581 is New York city ID.
    func fetchWeather(for cityID: Int = 5128581, _ completion: @escaping((Weather) -> Void)) {
        if let url = Endpoints.cityID(id: cityID).URL {
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
