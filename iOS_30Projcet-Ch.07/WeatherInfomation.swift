//
//  WeatherInfomation.swift
//  iOS_30Projcet-Ch.07
//
//  Created by youngmo jung on 2021/12/22.
//

import Foundation

struct WeatherInfomation: Codable {
    let weather: [Weather]
    let temp: Temp
    let name: String
}

//weather json sample
//"weather":[{
//            "id":800,
//            "main":"Clear",
//            "description":"clear sky",
//            "icon":"01d"
//            }],

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

//temp json sample
//"main":{
//        "temp":269.57,
//        "feels_like":269.57,
//        "temp_min":267.86,
//        "temp_max":271.84,
//        "pressure":1024,
//        "humidity":68
//        },

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
