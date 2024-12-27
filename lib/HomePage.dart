import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/ListViewData.dart';
import 'package:weather_app/NextSevenDays.dart';
import 'package:weather_app/NextTwoDays.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final Function changeTheme;
  final bool light;
  final String locationMessage;
  final String selectedUnit;
  final Function changeUnit;
  final String selectedCity;
  final Function changeCity;
  final Function checkCity;
  final Function checkUnit;

  const HomePage(
      {super.key,
      required this.changeTheme,
      required this.light,
      required this.locationMessage,
      required this.selectedUnit,
      required this.changeUnit,
      required this.selectedCity,
      required this.changeCity,
      required this.checkCity,
      required this.checkUnit});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random random = Random();
  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  // API WORK
  final String apiKey =
      ''; // Replace with your API key
  final String host = 'weatherapi-com.p.rapidapi.com';

  String query = "";

  List<String> days = [
    "Tomorrow",
    "Day after Tomorrow",
  ];

  List<String> nextDates = [];

  @override
  void initState() {
    super.initState();
    if (widget.selectedCity == "Unknown") {
      getCityFromLocation().then((city) {
        setState(() {
          query = city;
        });
        // print("unknown city: $city");
        fetchWeatherData();
      });
    } else {
      query = widget.selectedCity;
      fetchWeatherData();
    }
  }

  Future<String> getCityFromLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String city = placemark.locality ?? "Unknown"; // Ensure there's a fallback if locality is null
    return city;
  }


  Future<void> fetchWeatherData() async {
    final url = Uri.parse('https://$host/forecast.json?q=$query&days=3');
    // print("url: $url");
    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': host,
        },
      );

      // print("got response");

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false;
        });
        // print("response status code: ${response.statusCode}");
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // try for 10 seconds if still isLoading then display error
    Future.delayed(Duration(seconds: 10), () {
      if (isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load weather data')),
        );
        setState(() {
          isLoading = false;
        });
      }
    });


    // Accessing the fetched data
    final current = weatherData?['current'];
    final forecast = weatherData?['forecast']['forecastday'];
    final location = weatherData?['location'];
    final condition = current['condition'];
    final astro = forecast[0]['astro'];
    final icon = condition['icon'];

    // Extracting the hourly data
    final List<dynamic> hours = forecast[0]['hour'];

    // Extracting the next 2 days data
    final List<String> highs = [
      widget.selectedUnit == "Celsius"
          ? "${forecast[1]['day']['maxtemp_c']}"
          : "${forecast[1]['day']['maxtemp_f']}",
      widget.selectedUnit == "Celsius"
          ? "${forecast[2]['day']['maxtemp_c']}"
          : "${forecast[2]['day']['maxtemp_f']}",
    ];

    final List<String> lows = [
      widget.selectedUnit == "Celsius"
          ? "${forecast[1]['day']['mintemp_c']}"
          : "${forecast[1]['day']['mintemp_f']}",
      widget.selectedUnit == "Celsius"
          ? "${forecast[2]['day']['mintemp_c']}"
          : "${forecast[2]['day']['mintemp_f']}",
    ];

    final List<String> dayIcons = [
      forecast[1]['day']['condition']['icon'],
      forecast[2]['day']['condition']['icon'],
    ];

    final List<double> weekPrecipitation = [
      forecast[1]['day']['totalprecip_in'],
      forecast[2]['day']['totalprecip_in'],
    ];

    final List<int> weekHumidity = [
      forecast[1]['day']['avghumidity'],
      forecast[2]['day']['avghumidity'],
    ];

    final List<String> nextDates = [
      forecast[1]['date'],
      forecast[2]['date'],
    ];

    final List<String> nextTexts = [
      forecast[1]['day']['condition']['text'],
      forecast[2]['day']['condition']['text'],
    ];

    // print("icon: $icon");

    // extract time from last_updated
    final time = current['last_updated'].toString().substring(11, 16);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          children: <Widget>[
            SizedBox.fromSize(
              size: const Size.fromHeight(50),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    // refresh the weather
                    fetchWeatherData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Weather refreshed')),
                    );
                  },
                  child: const Text(
                    "Refresh",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Image.network(
                          "https:$icon",
                          width: 140,
                          height: 140,
                          scale: 0.4,
                          color: Colors.blue,
                        ),
                        Text(
                          condition['text'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.selectedUnit == "Celsius"
                              ? "${forecast[0]['day']['maxtemp_c']}°C / ${forecast[0]['day']['mintemp_c']}°C" :
                              "${forecast[0]['day']['maxtemp_f']}°F / ${forecast[0]['day']['mintemp_f']}°F",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.selectedUnit == "Celsius"
                              ? "Feels like ${current['feelslike_c']}°C" :
                              "Feels like ${current['feelslike_f']}°F",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: Text(
                                widget.selectedUnit == "Celsius"
                                    ? "${current['temp_c']}°" :
                                    "${current['temp_f']}°",
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          location['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "${location['region']}, \n ${location['country']}",
                          style: const TextStyle(

                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "update at $time",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Wind",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['wind_kph']} km/h",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Humidity",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['humidity']}%",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Pressure",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['pressure_in']} inHg",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Sunrise",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${astro['sunrise']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Sunset",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${astro['sunset']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  //   wind dir
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Direction",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['wind_dir']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Visibility",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['vis_km']} km",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "UV Index",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['uv']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "Cloudiness",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${current['cloud']}%",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      // "Sunny, Low 23°C, High 29°C",
                      "${condition['text']}, Low ${forecast[0]['day']['mintemp_c']}°C, High ${forecast[0]['day']['maxtemp_c']}°C",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 220,
                    child: Listviewdata(
                      hours: hours,
                      selectedUnit: widget.selectedUnit,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            // Now a Container with next 7 days weather
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Upcoming days",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // NO API FOUND
                  // SizedBox( // Make sure the ListView is sized properly
                  //   child: Nextsevendays(
                  //     days: days,
                  //     highs: highs,
                  //     lows: lows,
                  //     dayIcons: dayIcons,
                  //     weekPrecipitation: weekPrecipitation,
                  //   ),
                  // ),
                  SizedBox(
                    height: 250,
                    child: Nexttwodays(
                      days: days,
                      highs: highs,
                      lows: lows,
                      dayIcons: dayIcons,
                      weekPrecipitation: weekPrecipitation,
                      weekHumidity: weekHumidity,
                      nextDates: nextDates,
                      nextTexts: nextTexts,
                      selectedUnit: widget.selectedUnit,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Center(
                child: Text(
                  "Weather App, Developed by: Manraj29",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
