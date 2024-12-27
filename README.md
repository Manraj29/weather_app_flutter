# Weather App 🌦️

A Flutter-based weather application that allows users to view weather details based on their location or a manually entered city. The app includes light and dark mode support, unit conversion between Celsius and Fahrenheit, and persistent user preferences using `SharedPreferences`.

---

## Features ✨

- **Current Weather Details:** Displays weather information based on the user’s current location or a manually entered city.
- **Unit Conversion:** Easily toggle between Celsius and Fahrenheit.
- **Theme Switching:** Supports both light and dark themes.
- **Persistent Preferences:** Remembers the user's last selected city and unit using `SharedPreferences`.
- **Dynamic Location:** Automatically fetches the user's current location and city using `Geolocator`.
- **Interactive UI:** User-friendly and responsive interface for smooth navigation.

---

## Screenshots 📸

| Home Page | City Selection | Settings Page | About Page |
|-----------|----------------|---------------|------------|
| ![Home Page](path/to/screenshot.png) | ![City Selection](path/to/screenshot.png) | ![Settings Page](path/to/screenshot.png) | ![About Page](path/to/screenshot.png) |

| 24-Hour Forecast | Next Two Days |
|------------------|---------------|
| ![24-Hour Forecast](path/to/screenshot.png) | ![Next Two Days](path/to/screenshot.png) |

| Light Mode | Dark Mode |
|------------|-----------|
| ![Light Mode](path/to/screenshot.png) | ![Dark Mode](path/to/screenshot.png) |

Logo: ![Weather App Logo](path/to/screenshot.png)

> Replace `path/to/screenshot.png` with the actual paths to your screenshots.

---

## Installation & Setup 🛠️
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/weather-app.git
   cd weather-app
    ```
Install Dependencies: Ensure you have Flutter installed and run:

2. **Install Dependencies:**
   ```bash
   flutter pub get
    ```
3. **Run the App:**
4. **Start the app on an emulator or connected device:**
   ```bash
   flutter run
    ```
   
---

## Usage 🧑‍💻
- **Default City:** The app automatically fetches your location and displays the weather for your city.
- **Change City:** Use the city input field to manually select another city. This preference will be saved for future use.
- **Toggle Unit:** Switch between Celsius and Fahrenheit in the settings.
- **Switch Theme:** Toggle between light and dark modes using the theme switcher.

---

## Dependencies 📦
This app utilizes the following Flutter packages:
- [geolocator](https://pub.dev/packages/geolocator) for location services.
- [geocoding](https://pub.dev/packages/geocoding) for converting coordinates into readable addresses.
- [shared_preferences](https://pub.dev/packages/shared_preferences) for persistent user preferences.
- [flutter](https://flutter.dev) framework for building the UI.

---

## Project Structure 🗂️
- **`main.dart`:** Entry point of the app.
- **`WeatherScreen.dart`:** Main screen displaying weather details.
- **`NavBar.dart`:** Navigation bar for switching between pages.
- **`HomePage.dart`:** Home screen with the current weather forecast.
- **`AboutPage.dart`:** Page with details about the app.
- **`SettingsPage.dart`:** Contains options for theme and unit conversion.
- **`CitySelectionPage.dart`:** Allows users to manually select a city.
- **`ListViewData.dart`:** Display the 24-hour weather forecast.
- **`NextTwoDays.dart`:** Display the weather forecast for the next two days. 
- **`utils/`:** Directory for helper functions and constants.

---

## Disclaimer 📢

The app relies on third-party APIs for weather data. While efforts are made to ensure accuracy, the app cannot guarantee the precision or timeliness of the information provided. Please use the data for general reference only and verify critical weather conditions from trusted sources.

---

## Credits 🌟

Weather API data by [RapidAPI - WeatherAPI.com](https://rapidapi.com/weatherapi/api/weatherapi-com).  

---

## Author 👨‍💻
Developed by **Manraj29**.