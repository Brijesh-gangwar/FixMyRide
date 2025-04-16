import 'package:flutter/material.dart';

class MechanicSelectionScreen extends StatefulWidget {
  const MechanicSelectionScreen({super.key});

  @override
  State<MechanicSelectionScreen> createState() =>
      _MechanicSelectionScreenState();
}

class _MechanicSelectionScreenState extends State<MechanicSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 25, bottom: 6),
            child: Text(
              'Recommended Mechanics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                    left: 20,
                    right: 4,
                    bottom: 6,
                  ),
                  child: build_mechanic_card(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget build_mechanic_card() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      // color: const Color.fromARGB(255, 218, 217, 217),
      child: Padding(
        padding: const EdgeInsets.only(top: 6, left: 2, right: 2, bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Image.asset(
                'assets/services/7.png',
                width: 80,
                height: 80,
              ),
            ),
            // CircleAvatar(
            //   backgroundImage: Image.asset('assets/services/1.png').image,
            //   radius: 40,
            // ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Name: ",
                        style: bold_font.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "Mechanic name", style: normal_font),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Age: ",
                        style: bold_font.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "26 years", style: normal_font),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Distance: ",
                        style: bold_font.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "10 km", style: normal_font),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Service rate: ",
                        style: bold_font.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "₹ 400", style: normal_font),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Rating: ",
                        style: bold_font.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "4.2", style: normal_font),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Book Now',
                    style: normal_font.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle bold_font = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle normal_font = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    color: Colors.white,
  );
}
