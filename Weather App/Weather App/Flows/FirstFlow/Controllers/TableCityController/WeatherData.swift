//
//  WeatherData.swift
//  Weather App
//
//  Created by macbook m1 on 17.07.22.
//

import Foundation

struct HourlyUnits: Codable {
    var time: String?
    var temperature_2m: String?
    var relativehumidity_2m: String?
    var windspeed_10m: String?
}

struct Hourly: Codable {
    var time: [String]?
    var temperature_2m: [Double]?
    var relativehumidity_2m: [Int]?
    var windspeed_10m: [Double]?
}

struct WeatherData: Codable {
    var hourly_units: HourlyUnits?
    var hourly: Hourly?
}
