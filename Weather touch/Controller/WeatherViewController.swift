//
//  ViewController.swift
//  Weather Touch
//
//  Created by Tonoy Rahman on 2020-10-21.
//

import UIKit
import CoreLocation



class WeatherViewController: UIViewController {
    
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchText: UITextField!
    
    
    var weatherControl = WeatherControl()
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
  
        weatherControl.delegate = self
        searchText.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    

}

//MARK: - UITextFieldDelegate



extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchText.endEditing(true)
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchText.endEditing(true)
    
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            
            return true
        } else {
            
            textField.placeholder = "Please type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if  let city = searchText.text {
            
            weatherControl.fetchWeather(cityName: city)
        }
        searchText.text = ""
    }
    
}


//MARK: - WeatherControlDelegate

extension WeatherViewController: WeatherControlDelegate {
    
    func didUpdateWeather(_ weatherControl: WeatherControl, weather: WeatheModel) {
        DispatchQueue.main.async {
            
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
        
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate



extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat  = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherControl.fetchWeather(latitude: lat, longitude: lon)
            
            
            
             //weatherControl.fetchWeather(latitude: lat, longitude: lon)
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
    }
    
}





































































































































