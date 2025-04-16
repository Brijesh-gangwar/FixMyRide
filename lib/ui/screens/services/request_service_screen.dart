import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mech_app/data/globals.dart';
import 'package:mech_app/services/api_services/token_sevice.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  TextEditingController problemController = TextEditingController();

  // TextEditingController longitdecontroller = TextEditingController();
  // TextEditingController latitudecontroller = TextEditingController();
  TextEditingController vehiclecontroller = TextEditingController();
  bool isLoading = false;
  String? selectedService;
  String loc_message = 'Enter your location';
  String current_longitude = '';
  String current_latitude = '';
  int vehicle = 1;

  Future<void> send_request() async {
    bearer_token = await TokenService.getToken();
    if (bearer_token == null) {
      print("❌ Error: No token found.");
      return null;
    }
    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse("$api_url/request-services/"),

      headers: {
        // "Content-Type": "application/json",
        "Authorization": "Bearer $bearer_token",
      },
      body: jsonEncode({
        "problem": problemController.text.trim(),
        "latitude": current_longitude,
        "longitude": current_latitude,
        "vehicle": vehicle,
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Request Send successfully.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request Send failed! Check details.")),
      );
    }
  }

  /// Fetches current location
  Future<void> _getLocation() async {
    setState(() {
      isLoading = true;
    });

    Location location = Location();

    try {
      LocationData locationData = await location.getLocation();
      String newLocation =
          "Lat: ${locationData.latitude}, Lng: ${locationData.longitude}";

      setState(() {
        current_longitude = locationData.longitude.toString();
        current_latitude = locationData.latitude.toString();
        loc_message =
            'Latitude :  $current_latitude,Longitude : $current_longitude';
        isLoading = false;
      });

      // Print location to debug console
      print("Current Location: $newLocation");
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text('Request Service', style: normalFont.copyWith(fontSize: 24)),
              SizedBox(height: 10),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: problemController,
                  decoration: InputDecoration(
                    hintText: "Describe problem...",
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 20),

              /// Select Car
              buildSelectCarMenu(),

              /// Get Location Button
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _getLocation, // Get location on click
                    child: Text("Get Location"),
                  ),

              display_location(),
              // current_latitude == ''
              //     ? display_loc(loc_message)
              //     : display_location(),
              ElevatedButton(
                onPressed: send_request,
                child: Text('Request for service'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget display_location() {
    return Stack(
      children: [
        display_loc(loc_message),
        Positioned(
          right: 20,
          top: 20,
          child: IconButton(
            onPressed: _getLocation,
            icon: Icon(Icons.gps_fixed),
          ),
        ),
      ],
    );
  }

  Widget display_loc(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 60,
        width: double.infinity,
        child: Text(message),
      ),
    );
  }

  /// Dropdown Menu for Car Selection
  Widget buildSelectCarMenu() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          filled: true,

          fillColor: Colors.grey[700],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        hint: Text("Select Car", style: TextStyle(color: Colors.white70)),
        value: selectedService,
        items: [
          DropdownMenuItem(
            value: "service1",
            child: buildCarCard('Honda', 'Model X'),
          ),
          DropdownMenuItem(
            value: "service2",
            child: buildCarCard('Toyota', 'Model Y'),
          ),
        ],
        selectedItemBuilder: (BuildContext context) {
          return [display_selected_car('Honda', 'Model X'), Text('Toyota')];
        },
        itemHeight: 70,
        onChanged: (value) {
          setState(() {
            selectedService = value;
          });
        },
      ),
    );
  }

  //car display widget
  Widget display_selected_car(String carName, String carModel) {
    return Row(
      children: [
        Image.asset('assets/services/7.png', width: 40, height: 50),
        SizedBox(width: 20),
        Text('$carName - ', style: boldFont),
        SizedBox(width: 8),
        Text(carModel, style: normalFont),
      ],
    );
  }

  /// Car Card Widget
  Widget buildCarCard(String carName, String carModel) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('assets/services/7.png', width: 40, height: 40),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vehicle: $carName", style: boldFont),
                Text("Model: $carModel", style: normalFont),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Text Styles
  TextStyle boldFont = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  TextStyle normalFont = TextStyle(fontSize: 14, color: Colors.white);
}





// import 'package:flutter/material.dart';

// class RequestServiceScreen extends StatefulWidget {
//   const RequestServiceScreen({super.key});

//   @override
//   State<RequestServiceScreen> createState() => _RequestServiceScreenState();
// }

// class _RequestServiceScreenState extends State<RequestServiceScreen> {
//   TextEditingController problem_controller = TextEditingController();
//   bool isLoading = false;

//   String? selectedService;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Request Service',
//                 style: normal_font.copyWith(fontSize: 24),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey), // Custom border color
//                   borderRadius: BorderRadius.circular(10), // Rounded corners
//                 ),
//                 child: TextField(
//                   controller: problem_controller,
//                   decoration: InputDecoration(
//                     hintText: "Describe problem...",
//                     border: InputBorder.none, // Removes default border
//                   ),
//                   maxLines: 5, // Allows multiple lines
//                 ),
//               ),
//               SizedBox(height: 20),
//               // select car
//               buildSelectCarMenu(),

//               //get location
//               SizedBox(height: 20),
//               isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                     onPressed: () {},
//                     child: Text("get location"),
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  

//   // Widget build_select_car_menu() {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(bottom: 10),
//   //     child: DropdownButtonFormField(
//   //       isExpanded: true,

//   //       decoration: InputDecoration(
//   //         filled: true,
//   //         fillColor: Colors.grey[800],
//   //         border: OutlineInputBorder(
//   //           borderRadius: BorderRadius.circular(5),
//   //           borderSide: BorderSide.none,
//   //         ),
//   //       ),
//   //       value: selectedService,
//   //       hint: Text("Select Service", style: TextStyle(color: Colors.white70)),
//   //       items: [
//   //         DropdownMenuItem(
//   //           child: build_car_card('honda', 'hdjg'),
//   //           value: "service1",
//   //         ),
//   //         DropdownMenuItem(
//   //           child: build_car_card('honda', 'hdjg'),
//   //           value: "service2",
//   //         ),
//   //       ],

//   //       // selectedItemBuilder: (BuildContext context) {
//   //       //   return [
//   //       //     build_car_card('Honda', 'Model X'),
//   //       //     build_car_card('Toyota', 'Model Y'),
//   //       //   ];
//   //       // },
//   //       onChanged: (value) {
//   //         setState(() {
//   //           selectedService = value;
//   //         });
//   //       },
//   //     ),
//   //   );
//   // }




//   // 2

//   Widget buildSelectCarMenu() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.grey[900], // Dark background for better visibility
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         hint: Text("Select Service", style: TextStyle(color: Colors.white70)),

//         value: selectedService, // Selected item

//         items: [
//           DropdownMenuItem(
//             value: "service1",
//             child: build_car_card('Honda', 'Model X'),
//           ),
//           DropdownMenuItem(
//             value: "service2",
//             child: build_car_card('Toyota', 'Model Y'),
//           ),
//         ],

//         // Ensure the selected item is displayed as a Card
//         selectedItemBuilder: (BuildContext context) {
//           return [
//             build_car_card('Honda', 'Model X'),
//             build_car_card('Toyota', 'Model Y'),
//           ];
//         },

//         onChanged: (value) {
//           setState(() {
//             selectedService = value;
//           });
//         },
//       ),
//     );
//   }


//   ///style
//   ///
//   TextStyle bold_font = TextStyle(
//     fontFamily: 'Lato',
//     fontSize: 14,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   );

//   TextStyle normal_font = TextStyle(
//     fontFamily: 'Lato',
//     fontSize: 14,
//     color: Colors.white,
//   );

//   // carsdd

//   Widget build_car_card(String car_name, String car_model) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
//       // color: const Color.fromARGB(255, 218, 217, 217),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 6, left: 2, right: 2, bottom: 6),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black, width: 2),
//               ),
//               child: Image.asset(
//                 'assets/services/7.png',
//                 width: 50,
//                 height: 50,
//               ),
//             ),
//             // CircleAvatar(
//             //   backgroundImage: Image.asset('assets/services/1.png').image,
//             //   radius: 40,
//             // ),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Vehicle type: ",
//                         style: bold_font.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(text: "Car", style: normal_font),
//                     ],
//                   ),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Company : ",
//                         style: bold_font.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(text: "Honda", style: normal_font),
//                     ],
//                   ),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Model: ",
//                         style: bold_font.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       TextSpan(text: "Swift", style: normal_font),
//                     ],
//                   ),
//                 ),

//                 // Text.rich(
//                 //   TextSpan(
//                 //     children: [
//                 //       TextSpan(
//                 //         text: "Service rate: ",
//                 //         style: bold_font.copyWith(fontWeight: FontWeight.bold),
//                 //       ),
//                 //       TextSpan(text: "₹ 400", style: normal_font),
//                 //     ],
//                 //   ),
//                 // ),

//                 // SizedBox(height: 10),

//                 // ElevatedButton(
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: Colors.grey[500],
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(0),
//                 //     ),
//                 //   ),
//                 //   onPressed: () {},
//                 //   child: Text(
//                 //     'Select',
//                 //     style: normal_font.copyWith(color: Colors.white),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


