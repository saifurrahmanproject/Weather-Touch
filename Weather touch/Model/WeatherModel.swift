//
//  WeatherModel.swift
//  Weather Touch
//
//  Created by Tonoy Rahman on 2020-10-25.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatheModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        
        switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
    
    }
    
    
    
}














































