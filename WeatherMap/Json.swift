//
//  Json.swift
//  WeatherMap
//
//  Created by Максим Солнцев on 6/24/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    var cod: String?
    var message: Double?
    var cnt: Int?
    var list: [List]
    var city: City
}

struct List: Decodable {
    var dt: Int?
    var main: Main
    var weather: [Weather]
    var clouds: Clouds
    var wind: Wind
    var sys: Sys
    var dt_txt: String?
}

struct Main: Decodable {
     var temp: Double?
 }

struct Weather: Decodable {
       var id: Int?
       var main: String?
       var description: String?
       var icon: String?
   }

struct Clouds: Decodable {
    var all: Int?
}

struct Wind: Decodable {
    var speed: Double?
    var deg: Double?
}

struct Sys : Decodable{
    var pod: String?
}

struct City: Decodable {
    var name: String
}
