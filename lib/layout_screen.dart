import 'package:flutter/material.dart';

import 'package:mech_app/ui/screens/home_screen.dart';
import 'package:mech_app/ui/screens/mechanic_selection_screen.dart';

import 'package:mech_app/ui/screens/profile_screen.dart';
import 'package:mech_app/ui/screens/services/contact_us.dart';
import 'package:mech_app/ui/screens/services/request_service_screen.dart';
import 'package:mech_app/ui/widgets/drawer_widget.dart';
import 'package:mech_app/ui/widgets/navbar_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),

    // ServiceSelectionScreen(),
    MechanicSelectionScreen(),
    RequestServiceScreen(),

    ContactUs(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
