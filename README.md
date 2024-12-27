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
| <img src="https://github.com/user-attachments/assets/f2be0210-86fd-4570-aaa0-932057f40da9" alt="home page" width="400px" /> | <img src="https://github.com/user-attachments/assets/36e5fead-6e0f-416f-86a5-9faec468ecfc" alt="city selection" width="400px"  />  | <img src="https://github.com/user-attachments/assets/255473cf-a666-4938-8a47-17bad41484ff" alt="settings page" width="400px"  />| <img src="https://github.com/user-attachments/assets/0ca167d8-ed23-4f8a-8682-b4b414e85229" alt="about page" width="400px"  /> |

| 24-Hour Forecast & Next Two Days |
|----------------------------------|
| <img src="https://github.com/user-attachments/assets/50efbe4e-30ff-4f18-9c33-647bc0bb4bc7" alt="forecast" width="400px"  />|

| Light Mode | Dark Mode |
|------------|-----------|
| <img src="https://github.com/user-attachments/assets/f2be0210-86fd-4570-aaa0-932057f40da9" alt="home page" width="400px" />  | <img src="https://github.com/user-attachments/assets/5413801e-b8b7-4873-b32d-28e5c76ed2e7" alt="dark mode" width="400px" /> |
<br>
Logo: <br><img src="https://github.com/user-attachments/assets/28dbabff-f1b6-4ed1-8f89-70927ced549d" alt="logo.png" width="200px"/>

---

## Installation & Setup 🛠️
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Manraj29/weather-app.git
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
- [http](https://pub.dev/packages/http) for API integration.
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
