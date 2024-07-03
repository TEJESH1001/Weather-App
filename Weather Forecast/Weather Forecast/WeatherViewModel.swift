//
//  WeatherViewModel.swift
//  Weather Forecast
//
//  Created by Gaddam, Nagatejesh on 02/07/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: WeatherResponse.CurrentWeather?
    @Published var forecast: [WeatherResponse.Forecast.ForecastDay] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiKey = "73b56056dfa542e5a70153658240207"

    func fetchWeather(for city: String) {
        isLoading = true
        errorMessage = nil

        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=3"
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            self.errorMessage = "Invalid URL"
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "Please enter valid city name."
                    return
                }

                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    self.currentWeather = weatherResponse.current
                    self.forecast = weatherResponse.forecast.forecastday
                } catch {
                    self.errorMessage = "Please enter valid city name."
                }
            }
        }
        
        task.resume()
    }
}
