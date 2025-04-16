import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _sendingMails() async {
  var _url = Uri.parse("mailto:brijeshgangwar296@gmail.com");
  
  if(!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $_url');
  }
}


class MailWidget extends StatelessWidget {
  const MailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _sendingMails,
          child: const Text('Send Mail'),
        ),
      ),
    );
  }
}