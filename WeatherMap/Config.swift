//
//  Config.swift
//  WeatherMap
//
//  Created by Максим Солнцев on 8/13/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation

struct Config {
    
        
    
    
        self.myWeather = weatherRespose
        self.getReady = true
        self.weaherTabelView.reloadData()
        self.cityLabel.text = self.myWeather!.city.name
        self.descriptionLabel.text = self.myWeather?.list[0].weather[0].description
        self.nowTempLabel.text = "\(Int((self.myWeather?.list[0].main.temp)!) - 273)°"
        self.iconImage.image = UIImage(named: (self.myWeather!.list[0].weather[0].icon)!)
        
   
    
}
