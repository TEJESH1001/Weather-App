//
//  ContentView.swift
//  Weather Forecast
//
//  Created by Gaddam, Nagatejesh on 02/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    
                VStack {
                    HStack {
                        TextField("Enter city name", text: $city, onCommit: {
                            viewModel.fetchWeather(for: city)
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                        Button(action: {
                            viewModel.fetchWeather(for: city)
                        }) {
                            Text("Search")
                        }
                        .padding()
                        .frame(width: 100, height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }

                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .foregroundStyle(.black)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        if let currentWeather = viewModel.currentWeather {
                            VStack {
                                Image(systemName: getWeatherIcon(condition: currentWeather.condition.text))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                Text("\(currentWeather.temp_c, specifier: "%.1f")°C")
                                    .font(.largeTitle)
                                    .padding()
                                Text(currentWeather.condition.text)
                                    .font(.title2)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .padding()
                            }
                        }

                        List(viewModel.forecast, id: \.date) { day in
                            ZStack {
                                Color(.blue)
                                    
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(day.date)
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: getWeatherIcon(condition: day.day.condition.text))
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                    Text("Max: \(day.day.maxtemp_c, specifier: "%.1f")°C")
                                        .foregroundColor(.red)
                                    Text("Min: \(day.day.mintemp_c, specifier: "%.1f")°C")
                                        .foregroundColor(.blue)
                                    Text(day.day.condition.text)
                                }
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                            }
                            .listRowInsets(EdgeInsets())
                        }
                        .background(Color.clear)
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Weather")
        }
    }

    func getWeatherIcon(condition: String) -> String {
        switch condition.lowercased() {
        case "clear", "sunny":
            return "sun.max.fill"
        case "cloudy":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "snow":
            return "snow"
        case "thunderstorm":
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
        }
    }
}

#Preview {
    ContentView()
}
