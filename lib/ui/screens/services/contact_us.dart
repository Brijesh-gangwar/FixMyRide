import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[990],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              build_image_ui(),
              SizedBox(height: 10),
              _buildTextField("Full Name"),
              _buildTextField("Email Address"),
              build_drop_down(),
              _buildTextField("Write what you need"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Request a Service"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget build_drop_down() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
        ),
        hint: Text("Select Service", style: TextStyle(color: Colors.white70)),
        items: [
          DropdownMenuItem(child: Text("Service 1"), value: "service1"),
          DropdownMenuItem(child: Text("Service 2"), value: "service2"),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget build_image_ui() {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/h1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 60,
          top: 10,

          child: Text(
            'Contact Us',

            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          width: 300,
          child: Text(
            "Optimize your vehicle performance with our Auto Services.",
            style: TextStyle(fontSize: 18, color: Colors.white),
            maxLines: 2, // Allow only 2 lines
            overflow: TextOverflow.ellipsis, // Show "..." if text is too long
          ),
        ),
      ],
    );
  }
}
