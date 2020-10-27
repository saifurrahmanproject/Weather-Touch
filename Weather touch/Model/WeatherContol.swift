//
//  WeatherControl.swift
//  Weather Touch
//
//  Created by Tonoy Rahman on 2020-10-25.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherControlDelegate {
    
    func didUpdateWeather(_ weatherControl: WeatherControl, weather: WeatheModel)
    func didFailWithError(error: Error)
    
}

struct WeatherControl {
    let weatheURL = "https://api.openweathermap.org/data/2.5/weather?appid=9e437c44ad1fb9c0db97d26a56c096ab&units=metric"
    
    var delegate: WeatherControlDelegate?
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatheURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees , longitude: CLLocationDegrees) {
        
        let urlString = "\(weatheURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
                
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatheModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedDAta = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedDAta.weather[0].id
            let temp = decodedDAta.main.temp
            let name = decodedDAta.name
            
            let weather = WeatheModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
         
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
  
    
}






















































































































