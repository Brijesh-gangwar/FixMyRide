// import 'package:flutter/material.dart';
// import 'package:mech_app/services/api_services/token_sevice.dart';
// import 'package:mech_app/ui/screens/auth/login_screen.dart';
// import 'package:mech_app/ui/screens/home_screen.dart';
// import 'package:mech_app/ui/screens/profile_screen.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkAuthStatus();
//   }

//   Future<void> checkAuthStatus() async {
//     await Future.delayed(Duration(seconds: 2)); // Splash delay
//     String? token = await TokenService.getToken(); // Get valid token

//     if (token != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => ProfileScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 20),
//             Text("Checking Authentication...", style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:mech_app/layout_screen.dart';
// import 'package:mech_app/services/api_services/token_sevice.dart';
// import 'package:mech_app/ui/screens/auth/login_screen.dart';
// import 'package:mech_app/ui/screens/home_screen.dart';
// import 'package:mech_app/ui/screens/profile_screen.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkAuthStatus();
//   }

//   Future<void> checkAuthStatus() async {
//     await Future.delayed(Duration(seconds: 2));

//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//       return;
//     }

//     String? token = await TokenService.getToken();

//     if (token != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LayoutScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 20),
//             Text("Checking Authentication...", style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mech_app/layout_screen.dart';
import 'package:mech_app/services/api_services/token_sevice.dart';
import 'package:mech_app/ui/screens/auth/login_screen.dart';

import 'package:mech_app/ui/screens/offline_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isConnected = true;
  bool _checkingConnection = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _listenToConnectivityChanges();
  }

  // Check internet connection initially
  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });

    if (!_isConnected) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OfflineScreen(onReconnect: _checkConnectivity),
        ),
      );
    } else {
      _authenticateUser();
    }
  }

  // Listen for internet connectivity changes in real time
  void _listenToConnectivityChanges() {
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      bool wasConnected = _isConnected;
      setState(() {
        _isConnected = results.any(
          (result) => result != ConnectivityResult.none,
        );
      });

      if (!wasConnected && _isConnected) {
        // If previously offline but now online, navigate back to profile/login
        _authenticateUser();
      } else if (wasConnected && !_isConnected) {
        // If internet goes off, navigate to offline screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => OfflineScreen(onReconnect: _checkConnectivity),
          ),
        );
      }
    });
  }

  // Authenticate user and navigate accordingly
  Future<void> _authenticateUser() async {
    String? token = await TokenService.getToken();
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LayoutScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Checking Internet Connection...",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
