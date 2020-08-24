//
//  ViewController.swift
//  WeatherMap
//
//  Created by Максим Солнцев on 6/24/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//api.openweathermap.org/data/2.5/weather?q=London&appid=32653a936b877cee90a3c33d46e3fef2

import UIKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
   
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nowTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var afterTomorrowTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var searchCity: UISearchBar!
    @IBOutlet weak var weaherTabelView: UITableView!
    
    var locManager = CLLocationManager()
    var myWeather: WeatherResponse? = nil
    let networking = Networking()
    var getReady: Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        searchCity.delegate = self
        weaherTabelView.dataSource = self
        weaherTabelView.rowHeight = 150
        
        let currentLocation: CLLocation!
        currentLocation = locManager.location
     
        let locUrl = "http://api.openweathermap.org/data/2.5/forecast?lat=\(currentLocation!.coordinate.latitude)&lon=\(currentLocation!.coordinate.longitude)&appid=32653a936b877cee90a3c33d46e3fef2"
              
              networking.request(urlString: locUrl) { (result) in
                  switch result {
                  case .success(let weatherRespose):
                      self.myWeather = weatherRespose
                      self.getReady = true
                      self.weaherTabelView.reloadData()
                      self.cityLabel.text = self.myWeather!.city.name
                      self.descriptionLabel.text = self.myWeather?.list[0].weather[0].description
                      self.nowTempLabel.text = "\(Int((self.myWeather?.list[0].main.temp)!) - 273)°"
                      self.iconImage.image = UIImage(named: (self.myWeather!.list[0].weather[0].icon)!)
                  case .failure(let error):
                          print(error)
              }
        }
    }
       
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))&appid=32653a936b877cee90a3c33d46e3fef2"
        
        networking.request(urlString: url) { [weak self] (result) in
            switch result {
            case .success(let weatherResponse):
                self?.myWeather = weatherResponse
                self?.getReady = true
                self?.weaherTabelView.reloadData()
                self?.cityLabel.text = self?.myWeather!.city.name
                self?.descriptionLabel.text = self?.myWeather?.list[0].weather[0].description
                self?.nowTempLabel.text = "\(Int((self?.myWeather?.list[0].main.temp)!) - 273)°"
                self?.iconImage.image = UIImage(named: (self?.myWeather!.list[0].weather[0].icon)!)
            case .failure(let error):
                print(error)
                
                //Прошу прощения за дублирование :(
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getReady {
            return self.myWeather!.list.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.dateLabel.text = self.myWeather?.list[indexPath.row].dt_txt
        cell.AfterTempLabel.text = "\(Int((self.myWeather?.list[indexPath.row].main.temp)!) - 273)°"
        cell.iconImage.image = UIImage(named: (self.myWeather!.list[indexPath.row].weather[0].icon)!)
        return cell
    }
}


    
    

