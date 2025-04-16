import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallWidget extends StatelessWidget {
  final String phoneNumber = "tel:+918433267372";

  _makingPhoneCall() async {
    var _url = Uri.parse(phoneNumber);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: _makingPhoneCall,
          child: Text("Call Now"),
        ),
      ),
    );
  }
}
