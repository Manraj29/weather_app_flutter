import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/AboutPage.dart';
import 'package:weather_app/SettingsPage.dart';
import 'package:weather_app/WeatherScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}
class _WeatherAppState extends State<WeatherApp> {
  bool light = true; // State for light/dark mode
  String locationMessage = ""; // Variable to store the location message
  String selectedUnit = "Celsius"; // Variable to store the selected unit
  String selectedCity = "Unknown"; // Variable to store the selected city

  // Function to toggle the light/dark mode
  void changeTheme() {
    setState(() {
      light = !light;
    });
  }

  // Function to toggle the unit
  void changeUnit(String unit) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('unit', unit);
    });

    setState(() {
      selectedUnit = unit;
    });
  }

  void checkUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? unit = prefs.getString('unit');
    if (unit != null) {
      setState(() {
        selectedUnit = unit;
      });
    } else {
      prefs.setString('unit', selectedUnit);
    }
  }

  // Check if the user has selected a city before and fetch it from SharedPreferences
  void checkCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? city = prefs.getString('city');

    if (city != null) {
      // If city is stored, use it
      setState(() {
        selectedCity = city;
      });
    } else {
      // If no city is saved, fetch the current location
      String city = await getCityFromLocation();
      setState(() {
        selectedCity = city;
      });
      // Save the city to SharedPreferences for future use
      prefs.setString('city', city);
    }
  }

  // Get the current position
  Future<String> getCityFromLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String city = placemark.locality ?? "Unknown"; // Ensure there's a fallback if locality is null
    return city;
  }

  // Change city logic
  void changeCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('city', city); // Save the new city to SharedPreferences

    setState(() {
      selectedCity = city;
    });
  }

  @override
  void initState() {
    super.initState();
    checkCity(); // Check the city when the app starts
    checkUnit();
    _getUserLocation();
  }

  // Method to get user's location and city name
  Future<void> _getUserLocation() async {
    // Check for location permission
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Get the city name from latitude and longitude
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String? city = placemark.locality;
    String? country = placemark.country;
    setState(() {
      locationMessage = "You are in $city, $country.";
    });
    print(locationMessage);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[700],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[700],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple,
        ),
      ),
      themeMode: light ? ThemeMode.light : ThemeMode.dark,
      home: WeatherScreen(
        changeTheme: changeTheme,
        light: light,
        locationMessage: locationMessage,
        selectedUnit: selectedUnit,
        changeUnit: changeUnit,
        selectedCity: selectedCity,
        changeCity: changeCity,
        checkCity: checkCity, // Pass the checkCity function to your screens
        checkUnit: checkUnit,
      ),
    );
  }
}
