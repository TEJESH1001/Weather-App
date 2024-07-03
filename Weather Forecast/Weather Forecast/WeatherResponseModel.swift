//
//  WeatherResponseModel.swift
//  Weather Forecast
//
//  Created by Gaddam, Nagatejesh on 02/07/24.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime_epoch: Int
        let localtime: String
    }
    
    struct CurrentWeather: Codable {
        let last_updated_epoch: Int
        let last_updated: String
        let temp_c: Double
        let condition: Condition
        let wind_kph: Double
        let humidity: Int
        let feelslike_c: Double
        
        struct Condition: Codable {
            let text: String
            let icon: String
            let code: Int
        }
    }
    
    struct Forecast: Codable {
        let forecastday: [ForecastDay]
        
        struct ForecastDay: Codable {
            let date: String
            let day: Day
            
            struct Day: Codable {
                let maxtemp_c: Double
                let mintemp_c: Double
                let avgtemp_c: Double
                let condition: Condition
                
                struct Condition: Codable {
                    let text: String
                    let icon: String
                    let code: Int
                }
            }
        }
    }
}

