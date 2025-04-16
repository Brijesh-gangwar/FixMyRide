import 'package:flutter/material.dart';
import 'package:mech_app/data/models/customer_model.dart';
import 'package:mech_app/services/api_services/user.dart';

class EditProfileScreen extends StatefulWidget {
  final CustomerModel user;
  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  bool isLoading = false;
  bool success = false;

  CustomerModel? user;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phoneNumber);

    setState(() {
      user = widget.user;
    });


  }

    void updateProfile() async {
    setState(() => isLoading = true);

    Map<String, dynamic> updatedData = {
      "name": nameController.text,
      "email": emailController.text,
      "phone_number": phoneController.text,
    };

    final sample_bool = await UserServices.updateCustomerProfile(widget.user.id, updatedData);
    setState(() => isLoading = false);

    setState(() {
      success = sample_bool!;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Updated!")));
      Navigator.pop(context, true); // Return to previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Failed!")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: updateProfile,
                  child: Text("Save Changes"),
                ),
          ],
        ),
      ),
    );
  }
}
