import 'package:flutter/material.dart';
import 'package:mech_app/services/api_services/token_sevice.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// main
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mech_app',
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

// splash screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Splash delay
    String? token = await TokenService.getToken(); // Get valid token

    if (token != null) {
      print(token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => E1()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
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
            Text("Checking Authentication...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse("https://mechanic-backend-rofz.onrender.com/api/login/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone_number": phoneController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // await _saveTokens(data['access'], data['refresh']);

      await TokenService.saveTokens(data['access'], data['refresh']);
      print(data['access']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => E1()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed! Check credentials.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text("Login"),
                ),
          ],
        ),
      ),
    );
  }
}

// E1 screen
// class E1 extends StatefulWidget {
//   const E1({super.key});

//   @override
//   State<E1> createState() => _E1State();
// }

// class _E1State extends State<E1> {
//   final TextEditingController problemcon = TextEditingController();
//   final TextEditingController latitudecon = TextEditingController();
//   final TextEditingController longitudecon = TextEditingController();
//   final TextEditingController vehiclecon = TextEditingController();
//   bool isLoading = false;

//   Future<void> request_ser() async {
//     try {
//       setState(() => isLoading = true);
//       //token
//       String? token = await TokenService.getToken();

//       if (token == null) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Token not found!")));
//         return;
//       }
//       final response = await http.post(
//         Uri.parse(
//           "https://mechanic-backend-rofz.onrender.com/api/service-requests/",
//         ),
//         headers: {"Authorization": "Bearer $token"},
//         body: jsonEncode({
//           "problem": problemcon.text.trim(),
//           "latitude": latitudecon,
//           "longitude": longitudecon,
//           "vehicle": 1,
//         }),
//       );

//       setState(() => isLoading = false);

//       if (response.statusCode == 200) {
//         // final Map<String, dynamic> data = jsonDecode(response.body);

//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("request success!")));
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("request failed! Check data.")));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("request service")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: problemcon,

//               decoration: InputDecoration(labelText: "problem"),
//             ),
//             TextField(
//               controller: latitudecon,

//               decoration: InputDecoration(labelText: "latitude"),
//             ),

//             TextField(
//               controller: longitudecon,

//               decoration: InputDecoration(labelText: "longitude"),
//             ),

//             TextField(
//               controller: vehiclecon,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: "vehicle"),
//             ),
//             SizedBox(height: 20),
//             isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//                   onPressed: () {
//                     request_ser();
//                   },
//                   child: Text("request service"),
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class E1 extends StatefulWidget {
  const E1({super.key});

  @override
  State<E1> createState() => _E1State();
}

class _E1State extends State<E1> {
  final TextEditingController problemcon = TextEditingController();
  final TextEditingController latitudecon = TextEditingController();
  final TextEditingController longitudecon = TextEditingController();
  final TextEditingController vehiclecon = TextEditingController();
  bool isLoading = false;

  Future<void> request_ser() async {
    try {
      setState(() => isLoading = true);

      // Simulating token retrieval function
      String? token = await TokenService.getToken();
      if (token == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Token not found!")));
        setState(() => isLoading = false);
        return;
      }

      final response = await http.post(
        Uri.parse(
          "https://mechanic-backend-rofz.onrender.com/api/service-requests/",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "problem": problemcon.text.trim(),
          "latitude": latitudecon.text, // Keeping as string
          "longitude": longitudecon.text, // Keeping as string
          "vehicle": 1,
        }),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Request success!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Request failed! Check data.")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("An error occurred!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request Service")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: problemcon,
              decoration: const InputDecoration(labelText: "Problem"),
            ),
            TextField(
              controller: latitudecon,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Latitude"),
            ),
            TextField(
              controller: longitudecon,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Longitude"),
            ),
            TextField(
              controller: vehiclecon,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Vehicle"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: request_ser,
                  child: const Text("Request Service"),
                ),
          ],
        ),
      ),
    );
  }
}

// accept service

