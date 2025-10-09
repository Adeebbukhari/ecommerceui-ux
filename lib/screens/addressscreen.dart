// Importing Flutter's Material Design library
import 'package:flutter/material.dart';

// Declaring a stateful widget named AddressScreen
class AddressScreen extends StatefulWidget {
  // Constructor for AddressScreen (no custom parameters)
  const AddressScreen({super.key});

  // Creating state for the widget
  @override
  State<AddressScreen> createState() => _AddressScreen();
}

// Defining the state class for AddressScreen
class _AddressScreen extends State<AddressScreen> {
  // The build method describes the UI of this widget
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual structure (app bar, body, etc.)
    return Scaffold(
      // AppBar at the top of the screen
      appBar: AppBar(
        // Title displayed in the app bar
        title: Text("Saved Address"),

        // Back button to navigate to the previous screen
        leading: BackButton(),

        // Transparent background for the app bar
        backgroundColor: Colors.transparent,

        // Sets the color of icons/text in the app bar to black
        foregroundColor: Colors.black,

        // Removes shadow from the app bar
        elevation: 0,
      ),

      // The main body of the page
      body: Center(
        // Displays a placeholder text
        child: Text("Page Will be added after the Backend is prepared."),
      ),
    );
  }
}
