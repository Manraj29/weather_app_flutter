import 'package:flutter/material.dart';

class Nextsevendays extends StatefulWidget {
  final List<String> days;
  final List<int> highs;
  final List<int> lows;
  final List<IconData> dayIcons;
  final List<int> weekPrecipitation;

  const Nextsevendays({
    super.key,
    required this.days,
    required this.highs,
    required this.lows,
    required this.dayIcons,
    required this.weekPrecipitation,
  });

  @override
  State<Nextsevendays> createState() => _NextsevendaysState();
}

class _NextsevendaysState extends State<Nextsevendays> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Data Rows
        for (int i = 0; i < widget.days.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Day Column with fixed width
                SizedBox(
                  width: 105,  // Set fixed width for "Days" column
                  child: Text(
                    widget.days[i],
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                  ),
                ),
                // High Temperature Column
                Expanded(
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          "${widget.highs[i]}°",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Low Temperature Column
                Expanded(
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          "${widget.lows[i]}°",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Weather Icon Column
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: Center(
                    child: Icon(
                      widget.dayIcons[i],
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                // Precipitation Column
                Expanded(
                  child: Row(
                    // right align the text and icon
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.weekPrecipitation[i]}%",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                        child: Icon(
                          Icons.water_drop,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
