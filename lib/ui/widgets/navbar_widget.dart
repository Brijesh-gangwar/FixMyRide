import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const NavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      iconSize: 30,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      backgroundColor: const Color.fromARGB(255, 27, 24, 24),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_crash_sharp),
          label: "Services",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outlined),
          label: "Request",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Contact Us"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        //
      ],
    );
  }
}
