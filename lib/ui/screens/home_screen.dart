import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              //searchbar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),

              // services
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Services',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,

                    itemBuilder: (context, index) {
                      return build_accessories_card(
                        'Service ${index + 1}',
                        'assets/services/${index + 1}.png',
                      );
                    },
                  ),
                ),
              ),

              // remaining space
              const SizedBox(height: 20),
              // Add more widgets here
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Accessories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(height: 120, child: build_accessories_list()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_accessories_card(String serviceName, String imagePath) {
    return Card(
      elevation: 20,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(imagePath, height: 50, width: 50),
          ),
          Text(serviceName),
        ],
      ),
    );
  }

  //
  Widget build_accessories_list() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (int i = 1; i <= 9; i++)
          build_accessories_card('Accessories $i', 'assets/services/$i.png'),
        // Add more service cards here
      ],
    );
  }
}
