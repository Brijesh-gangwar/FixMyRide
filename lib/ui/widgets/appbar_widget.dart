import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;

  const AppbarWidget({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final List<String> appTitles = [
      "Dashboard",
      "Resources",
      "Projects",
      "Tasks",
      "Departments",

    ];

    return AppBar(
      title: Text(appTitles[selectedIndex]),
      actions: const [
        Icon(Icons.notifications),
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          child: Icon(
            Icons.person_2_sharp,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
