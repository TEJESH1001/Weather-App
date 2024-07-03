# Weather-App

This is a simple weather app built using SwiftUI that fetches and displays weather information for a given city. The app provides current weather details and a forecast for the upcoming days, presented with an aesthetically pleasing UI that includes images and colors.

## Features

- Search for weather information by city name
- Display current temperature and weather condition with appropriate icons
- Show a 3-day weather forecast
- Background images for the main view and list items
- Rounded corners and styled buttons for a better user experience
- Navigation bar with a custom title color

## Usage

1. Enter the name of the city you want to check the weather for in the text field.
2. Press the "Search" button to fetch and display the weather information.
3. View the current weather conditions and the 3-day forecast.

## Code Overview

Used the MVVM architechture in this project.

### ContentView - View

The `ContentView` struct is the main view of the app. It contains a `TextField` for entering the city name, a `Button` to trigger the weather fetch, and displays the weather information.

### WeatherViewModel - ViewModel

The `WeatherViewModel` class is responsible for fetching the weather data from the API and storing it in observable properties. It handles the network requests and parsing of the JSON response.

### WeatherModel - Model

The WeatherModel is used to represent the weather data retrieved from a weather API. This model typically includes information such as the current temperature, weather conditions, and forecast data for multiple days.

