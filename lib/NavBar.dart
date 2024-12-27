import 'package:flutter/material.dart';

//Navbar is Bottom Navigation Bar

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.teal),
  Destination('About', Icons.info, Colors.cyan),
  Destination('Settings', Icons.settings, Colors.orange),
];

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.onChanged, required this.index});

  final ValueChanged<int> onChanged;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onChanged,
      items: allDestinations.map((Destination destination) {
        return BottomNavigationBarItem(
          icon: Icon(destination.icon),
          backgroundColor: destination.color,
          label: destination.title,
        );
      }).toList(),
    );
  }
}
