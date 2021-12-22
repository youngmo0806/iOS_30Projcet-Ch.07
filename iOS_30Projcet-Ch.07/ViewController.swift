//
//  ViewController.swift
//  iOS_30Projcet-Ch.07
//
//  Created by youngmo jung on 2021/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherNameLabel: UILabel!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func showAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)

    }
    
    func setWeatherView(weatherInfo: WeatherInfomation){
        
        self.cityNameLabel.text = weatherInfo.name
        
        if let weather = weatherInfo.weather.first {
          self.cityNameLabel.text = weather.description
        }
        
        self.tempLable.text = "\(Int(weatherInfo.temp.temp - 273.15))℃"
        self.minTempLabel.text = "최저: \(Int(weatherInfo.temp.minTemp - 273.15))℃"
        self.maxTempLabel.text = "최고: \(Int(weatherInfo.temp.maxTemp - 273.15))℃"
        
    }
    
    func getCurrentWeather(cityName: String) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=2fbda2ad1a542fd855f4bf0f429e810d") else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url){ data, response, error in
            let successCode = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse, successCode.contains(response.statusCode) {
                //정상 범주
                guard let data = try? decoder.decode(WeatherInfomation.self, from: data) else { return }
                print("result => \(data)")
                
                DispatchQueue.main.async {
                    self.weatherStackView.isHidden = false
                    self.setWeatherView(weatherInfo: data)
                }
                
            }else{
                //에러 alert 처리
                guard let data = try? decoder.decode(Error.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    self.showAlert(title: "error", message: data.message)
                }
            }
            
        }.resume()
        
    }
    
    @IBAction func getWeatherInfo(_ sender: UIButton) {
        
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.cityNameTextField.endEditing(true)
        }
        
        
        
    }
}

