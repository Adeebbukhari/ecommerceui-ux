// Import necessary Flutter and third-party packages
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart'; // ✅ For the animated bottom navigation bar
import 'package:ecommerce/screens/favoritescreen.dart'; // ✅ Importing FavoriteScreen
import 'package:ecommerce/screens/homescreen.dart'; // ✅ Importing HomeScreen
import 'package:ecommerce/screens/cartscreen.dart'; // ✅ Importing CartScreen
import 'package:ecommerce/screens/profilescreen.dart'; // ✅ Importing ProfileScreen
import 'package:flutter/cupertino.dart'; // ✅ For Cupertino icons
import 'package:flutter/material.dart'; // ✅ For Flutter's core UI widgets

// Main widget class representing the Navigation screen
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key}); // ✅ Constructor with optional key

  @override
  State<NavigationScreen> createState() => _NavigationScreenState(); // ✅ Creates the mutable state
}

// State class for NavigationScreen
class _NavigationScreenState extends State<NavigationScreen> {
  // Variable to track the current selected page index
  int pageIndex = 0;

  // List of pages to be shown in the bottom navigation
  List<Widget> pages = [
    HomeScreen(), // ✅ Home tab
    Cartscreen(), // ✅ Cart tab
    FavoriteScreen(), // ✅ Favorites tab
    ProfileScreen(), // ✅ Profile tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The main body of the screen
      body: IndexedStack(
        index: pageIndex, // ✅ Shows the currently active page
        children: pages, // ✅ List of all pages
      ),

      // Bottom navigation bar section
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          CupertinoIcons.home, // ✅ Home icon
          CupertinoIcons.cart, // ✅ Cart icon
          CupertinoIcons.heart, // ✅ Favorite icon
          CupertinoIcons.profile_circled, // ✅ Profile icon
        ],

        // ✅ Colors and appearance setup
        inactiveColor: Colors.black.withOpacity(0.5), // Color of unselected icons
        activeColor: Color(0xfffe6969), // Color of the selected icon
        gapLocation: GapLocation.none, // No floating gap or notch
        activeIndex: pageIndex, // ✅ Current selected index
        notchSmoothness: NotchSmoothness.softEdge, // Smooth edge animation for transitions
        leftCornerRadius: 10, // Rounded corner (left)
        rightCornerRadius: 10, // Rounded corner (right)
        iconSize: 25, // Size of icons
        elevation: 0, // Remove shadow/elevation

        // ✅ Handles tapping on icons
        onTap: (index) {
          setState(() {
            pageIndex = index; // ✅ Updates the index and refreshes the UI
          });
        },
      ),
    );
  }
}
