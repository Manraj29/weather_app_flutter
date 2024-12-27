import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CountryStateCityPicker extends StatefulWidget {
  final Function changeCity;
  const CountryStateCityPicker({super.key, required this.changeCity});

  @override
  State<CountryStateCityPicker> createState() => _CountryStateCityPickerState();
}

class _CountryStateCityPickerState extends State<CountryStateCityPicker> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Close button

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text('Reset'),
                onPressed: () {
                  setState(() {
                    countryValue = "";
                    stateValue = "";
                    cityValue = "";

                  });
                  getCityFromLocation().then((city) {
                    widget.changeCity(city);
                  });
                  // snackbr
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('City reset to current location')),
                  );
                  Navigator.of(context).pop();
                },
              ),
              // add 10px space
              SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.close),
                iconSize: 30,
                hoverColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SelectState(
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodyMedium?.color),
            onCountryChanged: (value) {
              setState(() {
                countryValue = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                stateValue = value;
              });
            },
            onCityChanged: (value) {
              setState(() {
                cityValue = value;
              });
              // Only change city if value is not empty
              if (value.isNotEmpty) {
                widget.changeCity(value); // Call changeCity from parent widget
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('City set to $value')),
                );
              } else {
                // Optional: Show a message or reset to default city
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a valid city')),
                );
              }
            },
          ),
          const Divider(thickness: 1),
          // Instructions text
          Text(
            'Please select your country, state and city in order to set the city',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
