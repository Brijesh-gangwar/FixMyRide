import 'package:flutter/material.dart';
import 'package:mech_app/data/models/customer_model.dart';

import 'package:mech_app/services/api_services/token_sevice.dart';
import 'package:mech_app/services/api_services/user.dart';
import 'package:mech_app/ui/screens/auth/login_screen.dart';
import 'package:mech_app/ui/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CustomerModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    CustomerModel? fetchedUser = await UserServices.fetchUserProfile();
    setState(() {
      user = fetchedUser;
      isLoading = false;
    });
  }

  void loggut() async {
    await TokenService.clearTokens();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void navigateToEditProfile() async {
    bool? updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen(user: user!)),
    );

    if (updated == true) {
      _loadUserProfile(); // Reload profile data
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : user == null
                ? Center(child: Text("Failed to load user data."))
                : Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,

                              // backgroundImage: NetworkImage(
                              //   user!.profileImageUrl != null
                              //       ? user!.profileImageUrl!
                              //       : 'https://example.com/default_profile_image.png',
                              // ),
                              backgroundImage:
                                  Image.asset('assets/services/1.png').image,
                            ),

                            Positioned(
                              top: 118,
                              right: 2,
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  semanticLabel: 'Edit Profile',

                                  size: 30,
                                  weight: 10,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),

                        buildProfileCard("Name", user!.name),
                        buildProfileCard(
                          "Verified User",
                          user!.verified ? "Yes" : "No",
                        ),
                        buildProfileCard("Name", user!.email),
                        buildProfileCard("Phone number", user!.phoneNumber),
                        buildProfileCard(
                          "Secondary Phone Number",
                          user!.secondaryPhoneNumber ?? "N/A",
                        ),

                        buildProfileCard("Aadhar Details", user!.aadharCard),

                        ///edit porfile
                        // ElevatedButton(
                        //   onPressed: navigateToEditProfile,
                        //   child: Text("Edit Profile"),
                        // ),
                      ],
                    ),
                  ),
                ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[200],
          onPressed: loggut,
          child: Icon(Icons.edit, color: Colors.black),
        ),
      ),
    );
  }

  Widget buildProfileCard(String title, String value) {
    return Container(
      width: double.infinity,

      height: 90,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 212, 212, 212),
              ),
            ),

            Divider(
              color: Colors.white, // White color line
              thickness: 1, // Line thickness
            ),
          ],
        ),
      ),
    );
  }
}
