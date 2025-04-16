import 'package:flutter/material.dart';
import 'package:location/location.dart';

class GetCurrentLocationWidget extends StatefulWidget {
  final Function(double, double) onLocationRetrieved; 

  const GetCurrentLocationWidget({Key? key, required this.onLocationRetrieved}) : super(key: key);

  @override
  State<GetCurrentLocationWidget> createState() => _GetCurrentLocationWidgetState();
}

class _GetCurrentLocationWidgetState extends State<GetCurrentLocationWidget> {
  bool isLoading = false;
  Location location = Location();
  String? errorMessage;
  double? latitude;
  double? longitude;

  Future<void> _getLocation() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Check permission
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() => errorMessage = "Location service is disabled.");
          return;
        }
      }

      // Request permission
      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.granted) {
          setState(() => errorMessage = "Location permission denied.");
          return;
        }
      }

      // Get current location
      LocationData locationData = await location.getLocation();
      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
      });

      // Pass coordinates back
      widget.onLocationRetrieved(latitude!, longitude!);
    } catch (e) {
      setState(() => errorMessage = "Error: ${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (latitude != null && longitude != null)
          Text(
            "Latitude: $latitude\nLongitude: $longitude",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        else if (errorMessage != null)
          Text(errorMessage!, style: TextStyle(color: Colors.red)),

        const SizedBox(height: 10),

        isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _getLocation,
                child: Text("Get Current Location"),
              ),
      ],
    );
  }
}
