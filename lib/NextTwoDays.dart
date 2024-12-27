import 'package:flutter/material.dart';

class Nexttwodays extends StatefulWidget {
  final List<String> days;
  final List<String> highs;
  final List<String> lows;
  final List<String> dayIcons;
  final List<double> weekPrecipitation;
  final List<int> weekHumidity;
  final List<String> nextDates;
  final List<String> nextTexts;
  final String selectedUnit;
  const Nexttwodays(
      {super.key,
      required this.days,
      required this.highs,
      required this.lows,
      required this.dayIcons,
      required this.weekPrecipitation,
      required this.weekHumidity, required this.nextDates, required this.nextTexts, required this.selectedUnit});

  @override
  State<Nexttwodays> createState() => _NexttwodaysState();
}

class _NexttwodaysState extends State<Nexttwodays> {
  @override
  Widget build(BuildContext context) {
    final days = widget.days;
    final highs = widget.highs;
    final lows = widget.lows;
    final dayIcons = widget.dayIcons;
    final weekPrecipitation = widget.weekPrecipitation;
    final weekHumidity = widget.weekHumidity;
    final nextDates = widget.nextDates;

    print(dayIcons);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      // add divider between the two days
      children: [
        for (int i = 0; i < widget.days.length; i++)
          Container(
            // right border for i < 1
            decoration: BoxDecoration(
              border: i < 1
                  ? Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    )
                  : null,
            ),
            // if i < 1, add padding to the right
            padding: i < 1
                ? EdgeInsets.only(right: 10)
                : EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nextDates[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  days[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                // network image
                Image.network(
                  "https:${dayIcons[i]}",
                  width: 50,
                  height: 50,
                  scale: 0.5,
                ),
                Text(
                  widget.nextTexts[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${widget.highs[i]}°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            " | ${widget.lows[i]}°",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                            size: 22,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.weekPrecipitation[i]}% ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.water_drop_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${widget.weekHumidity[i]}% ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.wb_sunny_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
