// Importing the OrderSuccessScreen file to navigate after confirming an order
import 'package:ecommerce/screens/ordersuccessscreen.dart';

// Importing the ShippingAddressScreen to change or update the delivery address
import 'package:ecommerce/screens/shippingadressscreen.dart';

// Importing Flutter's Material Design package for UI components
import 'package:flutter/material.dart';

// Importing a custom button widget used for the "Confirm Order" button
import '../widgets/container_button_modal.dart';

// Defining a stateless widget for the Confirm Order screen
class ConfirmOrderScreen extends StatelessWidget {
  // Constructor with optional key
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides a basic page structure: app bar + body
    return Scaffold(
      // AppBar displayed at the top
      appBar: AppBar(
        title: Text("Confrim Order "), // Title text in the app bar
        leading: BackButton(), // Back button to go to the previous screen
        backgroundColor: Colors.transparent, // Transparent background
        foregroundColor: Colors.black, // Black text/icon color
        elevation: 0, // Removes the default shadow
      ),

      // Allows scrolling for smaller screens
      body: SingleChildScrollView(
        child: SafeArea( // Keeps content away from system UI areas (notches, etc.)
          child: Padding(
            padding: EdgeInsets.all(20), // Adds space around the content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the left
              children: [
                SizedBox(height: 15), // Adds vertical space
                Text(
                  "Shipping Address", // Section title
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10), // Adds space below title

                // Container displaying user's saved shipping address
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15), // Inner horizontal padding
                  width: MediaQuery.of(context).size.width, // Full width of screen
                  height: 130, // Fixed height
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12, // Light shadow color
                        blurRadius: 4, // Softness of shadow
                        spreadRadius: 1, // Spread of shadow
                      ),
                    ],
                  ),
                  // Inner column for address content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row: Name and "Change" button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dear Customer", style: TextStyle(fontSize: 16)), // Placeholder name
                          TextButton(
                            onPressed: () {
                              // Navigate to Shipping Address Screen when "Change" is clicked
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShippingAdressScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Change",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xfffe6969), // Red accent color
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Street line of address
                      Text("02 Lovely", style: TextStyle(fontSize: 16)),
                      // City and postal address
                      Text(
                        "juhapura, Ahmedabad, Gujarat, India, 380055",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40), // Space before next section

                // Row showing Payment Method title and "Change" button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payement Method",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Placeholder for navigation to Payment Method Screen
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> PayementMethodScreen()));
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xfffe6969),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5), // Small vertical gap

                // Row displaying payment card image and masked card number
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Image.asset("assets/images/Visa.png"), // Card image
                    ),
                    SizedBox(width: 10), // Gap between image and text
                    Text("**** **** **** 5110"), // Masked card number
                  ],
                ),

                SizedBox(height: 40), // Space before next section

                // Delivery Method section title
                Text(
                  "Delivery Method",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10), // Space below title

                // Row showing delivery option image and estimated time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Image.asset("assets/images/icon3.png"), // Delivery icon
                    ),
                    Text(
                      "2-7 Days", // Estimated delivery time
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40), // Space before summary

                // Row showing Subtotal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub-Total",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "\$1000.54",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Row showing Shipping Fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping Fee",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "\$10",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Divider line separating total
                Divider(
                  height: 30,
                  color: Colors.black,
                ),

                // Row showing total payable amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Payement",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "\$1010.54",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffe6969),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30), // Space before confirm button

                // Confirm Order Button
                InkWell(
                  onTap: () {
                    // Navigate to Order Success Screen when confirmed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSuccessScreen(),
                      ),
                    );
                  },
                  // Custom button widget
                  child: ContainerButtonModal(
                    itext: "Confirm Order", // Button text
                    containerWidth: MediaQuery.of(context).size.width, // Full width
                    bgcolor: Color(0xfffe6969), // Red background
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
