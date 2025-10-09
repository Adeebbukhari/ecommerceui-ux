import 'package:ecommerce/widgets/container_button_modal.dart'; // Custom button widget
import 'package:flutter/material.dart'; // Flutter UI widgets
import 'confirmorderscreen.dart'; // Navigate to order confirmation screen

// Main Widget: Shipping Address Screen
class ShippingAdressScreen extends StatelessWidget {
  const ShippingAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with back button
      appBar: AppBar(
        title: Text("Add Shipping Address"), // Title of AppBar
        leading: BackButton(), // Default back button
        backgroundColor: Colors.transparent, // Transparent background
        foregroundColor: Colors.black, // Icon/text color
        elevation: 0, // Remove shadow
      ),
      // Scrollable body
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20), // Padding around content
            child: Column(
              children: [
                SizedBox(height: 50), // Top spacing

                // Full Name field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), // Border style
                    label: Text("Full Name"), // Label text
                  ),
                ),
                SizedBox(height: 25),

                // Address field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Address"),
                  ),
                ),
                SizedBox(height: 25),

                // City field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("City"),
                  ),
                ),
                SizedBox(height: 25),

                // State/Province field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("State/Province"),
                  ),
                ),
                SizedBox(height: 25),

                // Country field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Country"),
                  ),
                ),
                SizedBox(height: 25),

                // Zip Code field
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("ZipCode."),
                  ),
                ),
                SizedBox(height: 25),

                // Save Address button
                InkWell(
                  onTap: () {
                    // Navigate to Confirm Order Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmOrderScreen(),
                      ),
                    );
                  },
                  child: ContainerButtonModal(
                    itext: "Save Address", // Button text
                    bgcolor: Color(0xfffe6969), // Button color
                    containerWidth: MediaQuery.of(context).size.width, // Full width
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
