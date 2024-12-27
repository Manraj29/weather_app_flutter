import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CountryStateCityPicker.dart';

class SettingsPage extends StatefulWidget {
  final Function changeTheme;
  final bool light;
  final Function changeUnit;
  final String locationMessage;
  final String selectedCity;
  final Function changeCity;
  final String selectedUnit;
  const SettingsPage(
      {super.key,
      required this.changeTheme,
      required this.light,
      required this.locationMessage,
      required this.selectedUnit,
      required this.changeUnit,
      required this.selectedCity,
      required this.changeCity});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool get light => widget.light;
  Function get changeTheme => widget.changeTheme;
  String get locationMessage => widget.locationMessage;

  String get selectedUnit => widget.selectedUnit;
  String countryValue ="";
  String stateValue = "";
  String cityValue = "";

  // check if the user has selected a city before
  void checkCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? city = prefs.getString('city');
    if (city != null) {
      setState(() {
        widget.changeCity(city);
      });
    }
  }

  void checkUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? unit = prefs.getString('unit');
    if (unit != null) {
      setState(() {
        widget.changeUnit(unit);
      });
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


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox.fromSize(
              size: const Size.fromHeight(25),
            ),
            Text(
              'Settings',
              style: theme.textTheme.titleLarge,
            ),
            const Divider(
              thickness: 1,
            ),
            //   Add a button to change the theme
            ListTile(
              title: Text('Your Location'),
              subtitle: Text(locationMessage),
              onTap: () {
                getCityFromLocation().then((city) {
                  widget.changeCity(city);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('City reset to current location at $city'),
                    ),
                  );
                });
              },
            ),
            const Divider(
              thickness: 1,
            ),
            //   Add a button to navigate to the About page
            ListTile(
              title: Text('Temperature Unit'),
              subtitle: SizedBox(
                child: DropdownButton<String>(
                  value: selectedUnit,
                  // remove the icon
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    widget.changeUnit(value!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Temperature unit changed to $value'),
                      ),
                    );
                  },
                  items: <String>['Celsius', 'Fahrenheit']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            // add a button to add modal bottom sheet to select country, state and city
            ListTile(
              title: Text('City'),
              // change the color of the text
              subtitle: (widget.selectedCity == "")
                  ? Text('Select City below')
                  : Text(widget.selectedCity),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CountryStateCityPicker(changeCity: widget.changeCity);
                  },
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            SwitchListTile(
              title: Text(
                light ? 'Dark Mode' : 'Dark Mode ON',
                style: TextStyle(
                    color: theme.textTheme.titleSmall
                        ?.color), // Use current theme text color
              ),
              value: !light,
              activeColor: Colors.grey[100],
              onChanged: (bool value) {
                changeTheme();
              },
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
