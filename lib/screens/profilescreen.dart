import 'package:ecommerce/screens/addressscreen.dart';
import 'package:ecommerce/screens/favoritescreen.dart';
import 'package:ecommerce/screens/orderhistoryscreen.dart';
import 'package:ecommerce/storage/user_storage.dart'; // ✅ Import storage
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';   // ✅ To store fetched name
  String userEmail = '';  // ✅ To store fetched email

  @override
  void initState() {
    super.initState();
    loadUserData(); // ✅ Fetch data when screen opens
  }

  // ✅ Function to fetch user data from SharedPreferences
  Future<void> loadUserData() async {
    final userData = await UserStorage.getUserData();

    setState(() {
      userName = userData['name'] ?? 'Your Name';
      userEmail = userData['email'] ?? 'youremail@example.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // Body content
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Image
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),

            const SizedBox(height: 15),

            // ✅ Display User Name
            Text(
              userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // ✅ Display User Email
            Text(
              userEmail,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // Option List
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Color(0xfffe6969)),
              title: const Text("My Orders"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderHistoryScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Color(0xfffe6969)),
              title: const Text("Wishlist"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xfffe6969)),
              title: const Text("Saved Address"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddressScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Loginscreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
