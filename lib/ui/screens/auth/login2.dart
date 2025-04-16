// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:mech_app/ui/screens/auth/register_screen.dart';
// import 'package:mech_app/ui/screens/home_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();

//     Future<bool?> loging(String phone , String passoword) async {
//       final url = '';

//       try {
//          final response = await http.post(
//           Uri.parse('$baseUrl/login'),
//           headers: {"Content-Type": "application/json"},
//           body: json.encode({"phone_number": phone, "password": password}),
//       } catch (e) {
        
//       }
//     }

//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 163, 227, 247),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Center(
//           child: Text(
//             'Login',
//             style: TextStyle(color: Colors.white, fontSize: 28),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // SvgPicture.asset(
//                 //   "assets/logo.svg",
//                 //   width: 200,
//                 //   height: 200,
//                 // ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'phone number',
//                     // labelStyle: TextStyle(
//                     //   color: Colors.white,
//                     // ),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     // labelStyle: TextStyle(
//                     //   color: Colors.white,
//                     // ),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()),
//                       );
//                     }
//                   },
//                   child: const Text('Login'),
//                 ),
//                 const SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => RegisterScreen()),
//                     );
//                   },
//                   child: const Text(
//                     'Don\'t have an account? Sign up',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
