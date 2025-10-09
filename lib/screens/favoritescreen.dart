// Importing Flutter's Material Design library for UI components
import 'package:flutter/material.dart';

// Importing the local storage handler for managing favorite items
import '../storage/favorite_storage.dart';

// Importing global variables (if any are used across the app)
import '../globals.dart';

// Importing the product detail screen to navigate when a product is tapped
import 'productscreen.dart';

// Defining a StatefulWidget called FavoriteScreen
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key}); // Constructor with optional key

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState(); // Creates the state
}

// State class for FavoriteScreen
class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides structure for the screen (AppBar + Body)
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the default back arrow
        title: Text(
          "Favorites", // Title text in AppBar
          style: TextStyle(fontWeight: FontWeight.bold), // Bold title font
        ),
        backgroundColor: Colors.transparent, // Transparent AppBar background
        elevation: 0, // Removes shadow under AppBar
        foregroundColor: Colors.black, // Sets text/icon color to black
      ),

      // Body section with padding around the content
      body: Padding(
        padding: EdgeInsets.all(20), // 20px padding on all sides

        // ValueListenableBuilder listens for changes in the favoriteNotifier list
        child: ValueListenableBuilder<List<String>>(
          valueListenable: favoriteNotifier, // Notifier that tracks favorite IDs
          builder: (context, favorites, _) {
            // If there are no favorite items
            if (favorites.isEmpty) {
              return Center(
                child: Text("No favorites yet"), // Display message for empty state
              );
            }

            // Otherwise, build a scrollable list of favorite products
            return ListView.builder(
              itemCount: favorites.length, // Number of favorite items
              itemBuilder: (context, index) {
                final productId = favorites[index]; // Get product ID from list

                // Fetch product details asynchronously using FutureBuilder
                return FutureBuilder<Map<String, dynamic>?>(
                  future: FavoriteStorage.getProductById(productId), // Get product by ID
                  builder: (context, snapshot) {
                    // If data is still loading or not available, show empty space
                    if (!snapshot.hasData) return SizedBox();

                    // Once data is loaded, extract the product details
                    final product = snapshot.data!;

                    // Display each favorite product as a card
                    return Card(
                      elevation: 3, // Slight shadow under the card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                      margin: EdgeInsets.only(bottom: 16), // Space between cards
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12), // Inner padding for ListTile

                        // Display product thumbnail image on the left
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8), // Rounded image corners
                          child: Image.network(
                            product['thumbnail'], // Image URL
                            width: 60, // Fixed width
                            height: 60, // Fixed height
                            fit: BoxFit.cover, // Crop to cover space
                          ),
                        ),

                        // Product title text
                        title: Text(
                          product['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        // Product price text
                        subtitle: Text(
                          "\$${product['price']}", // Display price with $
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),

                        // Favorite icon button to remove item from favorites
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite, // Heart icon
                            color: Color(0xfffe6969), // Red color for favorite
                            size: 28, // Icon size
                          ),
                          onPressed: () {
                            setState(() {
                              // Toggle (add/remove) the product from favorites
                              FavoriteStorage.toggleFavorite(productId);
                            });
                          },
                        ),

                        // When the user taps the product card
                        onTap: () {
                          // Navigate to Productscreen and pass the product data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Productscreen(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
