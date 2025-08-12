import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: BackButton(),
      ),

      // Body content
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            // Profile Image
            CircleAvatar(
              radius: 50,
              child: 
                Icon(Icons.person),
            ),

            SizedBox(height: 15),

            // Name
            Text(
              "Your Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Email
            Text(
              "youremail@example.com",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 30),

            // Option List
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Color(0xfffe6969)),
              title: Text("My Orders"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Color(0xfffe6969)),
              title: Text("Wishlist"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xfffe6969)),
              title: Text("Settings"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
