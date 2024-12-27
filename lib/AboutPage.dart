import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Removed SizedBox.fromSize since it's unnecessary for scrolling content
            SizedBox.fromSize(
              size: const Size.fromHeight(25),
            ),
            Text(
              'About this app',
              style: theme.textTheme.titleLarge,
            ),
            const Divider(
              thickness: 1,
            ),
            // Title
            ListTile(
              subtitle: Text(
                'This Weather App provides real-time weather data fetched from the WeatherAPI.com.',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Powered by WeatherAPI.com',
                style: theme.textTheme.bodyMedium,
              ),
              subtitle: Text(
                'WeatherAPI.com provides accurate and up-to-date weather forecasts from around the world.',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'App Features:',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                '• Real-time weather information (temperature, humidity, wind speed, etc.)\n'
                    '• 7-day weather forecast\n'
                    '• Search by city or location\n'
                    '• Option to switch between Celsius and Fahrenheit',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Disclaimer:',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'This app is for educational purposes only. The weather data provided by WeatherAPI.com may not be 100% accurate. Please refer to the official WeatherAPI.com website for more information.',
                style: theme.textTheme.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  _launchURL('https://www.weatherapi.com/');
                },
                child: Text(
                  'Learn more at WeatherAPI.com',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      );
  }

  Future<void> _launchURL(String url) async {
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
