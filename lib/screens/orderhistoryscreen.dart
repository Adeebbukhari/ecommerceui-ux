// Importing the Flutter Material package which provides widgets and themes for Material Design
import 'package:flutter/material.dart';

// Defining a StatefulWidget named OrderHistoryScreen
class OrderHistoryScreen extends StatefulWidget {
  // Constructor with an optional key parameter (used for widget identification)
  const OrderHistoryScreen({super.key});

  // Creating and returning the mutable state object for this widget
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

// The state class that holds the mutable data for OrderHistoryScreen
class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    // The build method describes how to display the widget’s UI
    return Scaffold(
      // Scaffold provides the basic structure for the screen (AppBar, Body, etc.)

      appBar: AppBar(
        // The title text displayed in the AppBar
        title: Text("Order History"),

        // Adds a back arrow button to navigate to the previous screen
        leading: BackButton(),

        // Makes the AppBar background transparent
        backgroundColor: Colors.transparent,

        // Sets the color of the icons and text inside the AppBar
        foregroundColor: Colors.black,

        // Removes the default AppBar shadow
        elevation: 0,
      ),

      // The main content of the screen
      body: Center(
        // Centers the child widget horizontally and vertically
        child: Text(
          "Page Will be added after the Backend is prepared.",
          // The message displayed to inform that content is not yet ready
        ),
      ),
    );
  }
}
