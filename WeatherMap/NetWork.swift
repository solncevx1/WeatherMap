//
//  NetWork.swift
//  WeatherMap
//
//  Created by Максим Солнцев on 6/25/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import Foundation

class Networking {
    
    func request(urlString: String, complition: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data,
                    error == nil else {return}
                
                do {
                    let myWeather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    complition(.success(myWeather))
                    
                } catch  let error {
                    print(error)
                    complition(.failure(error))
                }
            }
        }.resume()
    }
}
