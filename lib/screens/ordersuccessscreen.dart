// Importing the main Navigation screen to navigate after order success
import 'package:ecommerce/screens/navigationscreen.dart';

// Importing Flutter Material package for UI components
import 'package:flutter/material.dart';

// Importing custom reusable button widget
import '../widgets/container_button_modal.dart';

// Stateless widget as the screen does not require mutable state
class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure for the screen (body, AppBar, etc.)
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center children vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Center children horizontally
        children: [
          // Display success image
          Image.asset("assets/images/success.png"),

          SizedBox(height: 15), // Vertical spacing

          // Main success message
          Text(
            "Success!",
            style: TextStyle(
              fontSize: 40, // Large font size
              fontWeight: FontWeight.bold, // Bold text
              letterSpacing: 1, // Slight spacing between letters
            ),
          ),

          SizedBox(height: 5), // Small space below title

          // Order delivery message
          Text(
            "Your Order will be delivered soon ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700, // Semi-bold text
            ),
          ),

          // Thank you message
          Text(
            "Thank You For Chosing Us",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700, // Semi-bold text
            ),
          ),

          SizedBox(height: 40), // Space before button

          // Padding around the button
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                // Navigate to NavigationScreen when button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(),
                  ),
                );
              },

              // Custom reusable button widget
              child: ContainerButtonModal(
                itext: "Continue Shopping", // Button text
                containerWidth: MediaQuery.of(context).size.width, // Full width
                bgcolor: Color(0xfffe6969), // Button background color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
