import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback onReconnect;

  OfflineScreen({required this.onReconnect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("No Internet Connection")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text("You are offline", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Check your connection and try again."),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onReconnect,
        child: Icon(Icons.refresh),
        tooltip: "Check Internet",
      ),
    );
  }
}





class Offliescree extends StatefulWidget {
  @override
  State<Offliescree> createState() => _OffliescreeState();
}

class _OffliescreeState extends State<Offliescree> {
  // List<String> services_title = [
  //   'fuel',
  //   'gps',
  //   'emergency',
  //   'towing',
  //   'cab service',
  //   'offline access',
  //   'instant repair',
  //   'women safety',
  //   'AI powered',
  // ];
  // List<String> services_image = [
  //   'assets/service1.jpg',
  //   'assets/service2.jpg',
  //   'assets/service3.jpg',
  //   'assets/service4.jpg',
  //   'assets/service5.jpg',
  //   'assets/service6.jpg',
  //   'assets/service7.jpg',
  //   'assets/service8.jpg',
  //   'assets/service9.jpg',
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/h1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Optimize Your Vehicle’s",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Performance with our Auto Services",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text("Schedule Now"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Statistics Section
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       _buildStat("200+", "Happy Clients"),
            //       _buildStat("100+", "Expert Mechanics"),
            //       _buildStat("50+", "Auto Services"),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 30),

            // Our Auto Repair Services
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Our Auto Repair Services",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // GridView.builder(
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 10,
                  //     mainAxisSpacing: 10,
                  //   ),
                  //   itemCount: services_title.length,
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       child: Column(
                  //         children: [
                  //           Image.asset(
                  //             'assets/services/$index.png',
                  //             width: 100,
                  //             height: 100,
                  //             fit: BoxFit.cover,
                  //           ),
                  //           Text("", style: TextStyle(color: Colors.white)),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  buildrevices(),
                  // _buildServiceTile(
                  //   "Spare Parts & Accessories Delivery",
                  //   'assets/service1.jpg',
                  // ),
                  // _buildServiceTile(
                  //   "On-Demand Car Wash & Detailing",
                  //   'assets/service2.jpg',
                  // ),
                  // _buildServiceTile(
                  //   "Emergency Fuel & Fluid Delivery",
                  //   'assets/service3.jpg',
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // About Us Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We offer top-notch vehicle repair services with skilled professionals and modern tools...",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Request a Quote"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Contact Form
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We Also Provide Excellent Mobile Auto Repair Service",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildTextField("Full Name"),
                  _buildTextField("Email Address"),
                  _buildTextField("Select Service"),
                  _buildTextField("Write what you need"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Request a Quote"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildStat(String value, String label) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: TextStyle(
  //           color: Colors.red,
  //           fontSize: 22,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
  //     ],
  //   );
  // }

  Widget buildrevices() {
    return Container(
      child: Column(
        children: [
          //1
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //1
                Column(
                  children: [
                    Image.asset(
                      'assets/services/1.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('Fuel', style: TextStyle(color: Colors.white)),
                  ],
                ),
                //2
                Column(
                  children: [
                    Image.asset(
                      'assets/services/2.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('GPS Tracking', style: TextStyle(color: Colors.white)),
                  ],
                ),

                Column(
                  children: [
                    Image.asset(
                      'assets/services/3.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Emergency service',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //2

          //3
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                //1
                Column(
                  children: [
                    Image.asset(
                      'assets/services/4.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('Towing', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/services/5.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('Cab Service', style: TextStyle(color: Colors.white)),
                  ],
                ),
                //2
                Column(
                  children: [
                    Image.asset(
                      'assets/services/6.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Offline Service',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //4
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //1
                Column(
                  children: [
                    Image.asset(
                      'assets/services/7.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Instant Repair',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                //2
                Column(
                  children: [
                    Image.asset(
                      'assets/services/8.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('Women safety', style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/services/9.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('Ai Powered', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildServiceTile(String title, String imagePath) {
  //   return Card(
  //     color: Colors.grey[900],
  //     child: ListTile(
  //       leading: Image.asset(
  //         imagePath,
  //         width: 50,
  //         height: 50,
  //         fit: BoxFit.cover,
  //       ),
  //       title: Text(title, style: TextStyle(color: Colors.white)),
  //       trailing: Icon(Icons.arrow_forward, color: Colors.red),
  //     ),
  //   );
  // }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
