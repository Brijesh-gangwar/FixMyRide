import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:mech_app/ui/widgets/sms_widget.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationMessage = "Press the button to get location (GPS only)";
  Location location = Location();

  String gis_location = "";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // Check if GPS is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = "GPS is disabled. Please enable it.";
        });
        return;
      }
    }

    // Check for location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          _locationMessage = "Location permission denied.";
        });
        return;
      }
    }

    // Get GPS location
    locationData = await location.getLocation();

    setState(() {
      _locationMessage =
          "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}";
      gis_location =
          locationData.latitude.toString() +
          ", " +
          locationData.longitude.toString();
    });

    print(
      "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}",
    );
    print(gis_location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Offline GPS Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.error, color: Colors.red, size: 70),
            Image.asset(
              'assets/icons/e1.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            //
            Text(
              'Emergency',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text(
                "Get current Location",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 30),

            Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10),
            gis_location == ""
                ? Text(
                  "No location data to send",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
                : gis_location.isEmpty
                ? CircularProgressIndicator()
                : SmsWidget(gis_location: gis_location),
          ],
        ),
      ),
    );
  }
}
