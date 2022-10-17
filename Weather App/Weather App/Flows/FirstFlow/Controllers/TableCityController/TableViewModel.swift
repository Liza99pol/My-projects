//
//  TableViewModel.swift
//  Weather App
//
//  Created by macbook m1 on 24.08.22.
//

import Foundation

struct CityInfo {
    
    var nameCity: String
    var lat: Double
    var lon: Double
    
}

class  TableViewModel {
    
    var weather = WeatherData()
    var cityName: String?
    
    var finishLoadData: (() -> Void)?
    
    let cityInfo: [CityInfo] = [CityInfo(nameCity: "Минск", lat: 53.5359, lon: 27.3400), CityInfo(nameCity: "Гродно", lat: 53.4118, lon: 23.4932), CityInfo(nameCity: "Гомель", lat: 52.2604, lon: 30.5831), CityInfo(nameCity: "Брест", lat: 52.0551, lon: 23.4115), CityInfo(nameCity: "Витебск", lat: 55.1125, lon: 30.1217)]
    
    
    
    func lowData(cityInfo: CityInfo) {
        
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(cityInfo.lat)&longitude=\(cityInfo.lon)&hourly=temperature_2m,relativehumidity_2m,windspeed_10m"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { [self] response, data, error in
                if let data = data {
                    if let weatherData: WeatherData = try? JSONDecoder().decode(WeatherData.self, from: data) {
                        
                        print(weatherData)
                        
                        self.cityName = cityInfo.nameCity
                        self.weather = weatherData
                        self.finishLoadData?()
    }
        
                }
            }
        }
    }
}
