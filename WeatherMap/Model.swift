//
//  Model.swift
//  WeatherMap
//
//  Created by Максим Солнцев on 6/24/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation

class WeatherDataSource {
    
    var sweather: [Weather] = []

    let urlString = "http://api.openweathermap.org/data/2.5/weather?q=London&appid=32653a936b877cee90a3c33d46e3fef2"
    
    func loadWeather() {
        
        let url = URL(string: urlString)
               
               URLSession.shared.dataTask(with: url!) { (data, response, error) in
                   guard let data = data,
                       error == nil else {return}
               
               
               do {
                   let myWeather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                   print(myWeather)
                   
                   if myWeather.cod == 200 {
                       self.sweather = myWeather.weather
                   } else { return }
                   
               } catch  let error {
                   print(error)
                   }
                   
               }.resume()


           }
        
    }
    


