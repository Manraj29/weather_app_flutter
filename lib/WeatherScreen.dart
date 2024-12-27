import 'package:flutter/material.dart';
import 'package:weather_app/NavBar.dart';
import 'package:weather_app/AboutPage.dart';
import 'package:weather_app/SettingsPage.dart';

import 'HomePage.dart';

class WeatherScreen extends StatefulWidget {
  final Function changeTheme;
  final bool light;

  final String selectedUnit;
  final Function changeUnit;
  final String locationMessage;

  final String selectedCity;
  final Function changeCity;

  final Function checkCity;
  final Function checkUnit;

  const WeatherScreen({super.key, required this.changeTheme, required this.light, required this.locationMessage, required this.selectedUnit, required this.changeUnit, required this.selectedCity, required this.changeCity, required this.checkCity, required this.checkUnit});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool resultsVisible = false;
  int page = 0;
  void onChanged(int value) {
    setState(() {
      page = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          //   display the page based on the index
            if (page == 0)
              HomePage(changeTheme: widget.changeTheme, light: widget.light, locationMessage: widget.locationMessage, selectedUnit: widget.selectedUnit, changeUnit: widget.changeUnit, changeCity: widget.changeCity, selectedCity: widget.selectedCity, checkCity: widget.checkCity, checkUnit: widget.checkUnit),
            if (page == 1)
              AboutPage(),
            if (page == 2)
              SettingsPage(changeTheme: widget.changeTheme, light: widget.light, locationMessage: widget.locationMessage, selectedUnit: widget.selectedUnit, changeUnit: widget.changeUnit, changeCity: widget.changeCity, selectedCity: widget.selectedCity),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(onChanged: onChanged, index: page,),
    );
  }
}
