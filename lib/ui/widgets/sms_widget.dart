import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsWidget extends StatelessWidget {
  const SmsWidget({super.key, required this.gis_location});
  final String gis_location;

  @override
  Widget build(BuildContext context) {
    //  function to send sms

    Future<void> _sendingSMS() async {
      var _url = Uri.parse("sms:8433267372?body=$gis_location");

      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $_url');
      }
    }

    return Container(
      child: ElevatedButton(
        onPressed: _sendingSMS,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        child: const Text('Share location'),
      ),
    );
  }
}
