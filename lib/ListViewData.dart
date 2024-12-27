import 'package:flutter/material.dart';

class Listviewdata extends StatefulWidget {
  final List<dynamic> hours;
  final String selectedUnit;
  const Listviewdata({
    super.key,
    required this.hours, required this.selectedUnit,
  });

  @override
  State<Listviewdata> createState() => _ListviewdataState();
}

class _ListviewdataState extends State<Listviewdata> {
  @override
  Widget build(BuildContext context) {
    final hours = widget.hours;
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (int i = 0; i < 24; i++)
          Container(
            width: 120,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hours[i]["time"].substring(11, 16),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Text(
                  widget.selectedUnit == "Celsius"
                      ? "${hours[i]["temp_c"]}°C"
                      : "${hours[i]["temp_f"]}°F",
                  style: TextStyle(
                    color: Colors.white,
                    // bold
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Image.network(
                  "https:${hours[i]["condition"]["icon"]}",
                  width: 50,
                  height: 50,
                  scale: 0.7,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  hours[i]["condition"]["text"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${hours[i]["precip_in"]} in ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.water_drop_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }
}
