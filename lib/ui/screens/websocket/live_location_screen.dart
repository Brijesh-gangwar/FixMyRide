import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(const LiveLocationApp());
}

class LiveLocationApp extends StatelessWidget {
  const LiveLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiveLocationScreen(),
    );
  }
}

class LiveLocationScreen extends StatefulWidget {
  const LiveLocationScreen({super.key});

  @override
  _LiveLocationScreenState createState() => _LiveLocationScreenState();
}

class _LiveLocationScreenState extends State<LiveLocationScreen> {
  final String userToken = "your_token_here"; // Replace with actual token
  final String wsUrl = "wss://your-websocket-server.com/location?token=";
  
  late WebSocketChannel channel;
  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  LatLng? myLocation;
  LatLng? otherUserLocation;
  List<LatLng> pathPoints = []; // Stores user's path

  @override
  void initState() {
    super.initState();
    _initLocation();
    _connectToWebSocket();
  }

  /// Initialize location and request permissions
  Future<void> _initLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check and request location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Start getting real-time location updates
    locationSubscription = location.onLocationChanged.listen((LocationData locData) {
      if (locData.latitude != null && locData.longitude != null) {
        LatLng newLocation = LatLng(locData.latitude!, locData.longitude!);
        setState(() {
          myLocation = newLocation;
          pathPoints.add(newLocation); // Store location in pathPoints
        });
        _sendLocationToWebSocket(newLocation);
      }
    });
  }

  /// Connect to WebSocket server
  void _connectToWebSocket() {
    String fullWsUrl = "$wsUrl$userToken";
    channel = WebSocketChannel.connect(Uri.parse(fullWsUrl));

    channel.stream.listen(
      (message) {
        _handleIncomingMessage(message);
      },
      onError: (error) {
        print("WebSocket Error: $error");
        _reconnectWebSocket();
      },
      onDone: () {
        print("WebSocket Disconnected");
        _reconnectWebSocket();
      },
    );
  }

  /// Handle incoming WebSocket messages (Other user's location)
  void _handleIncomingMessage(String message) {
    try {
      Map<String, dynamic> data = jsonDecode(message);
      double lat = data['latitude'];
      double lon = data['longitude'];
      setState(() {
        otherUserLocation = LatLng(lat, lon);
      });
    } catch (e) {
      print("Error parsing WebSocket message: $e");
    }
  }

  /// Send location to WebSocket
  void _sendLocationToWebSocket(LatLng location) {
    if (channel.sink != null) {
      Map<String, dynamic> data = {
        "latitude": location.latitude,
        "longitude": location.longitude
      };
      channel.sink.add(jsonEncode(data));
    }
  }

  /// Reconnect WebSocket if disconnected
  void _reconnectWebSocket() {
    Future.delayed(const Duration(seconds: 3), () {
      _connectToWebSocket();
    });
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Location & Path")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: myLocation ?? LatLng(0, 0),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          if (pathPoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: pathPoints, // The path to draw
                  color: Colors.blue,
                  strokeWidth: 4.0,
                ),
              ],
            ),
          if (myLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: myLocation!,
                  child: const Icon(Icons.person_pin, color: Colors.blue, size: 40),
                ),
              ],
            ),
          if (otherUserLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: otherUserLocation!,
                  child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
