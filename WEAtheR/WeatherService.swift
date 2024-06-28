//
//  WeatherService.swift
//  weather
//
//  Created by Scholar on 6/21/24.
//

import Foundation
import CoreLocation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}

class WeatherService {
    private let apiKey = "0d7c65485ce6665d40c339a03504fbf1"  // Replace with your OpenWeatherMap API key

    func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            DispatchQueue.main.async {
                completion(weatherResponse)
            }
        }.resume()
    }
}
