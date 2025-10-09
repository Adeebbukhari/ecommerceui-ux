// Importing necessary packages
import 'package:auto_size_text/auto_size_text.dart'; // For auto-adjusting text size
import 'package:ecommerce/screens/productscreen.dart'; // Product detail screen
import 'package:flutter/material.dart'; // Flutter UI framework
import '../api/api_service.dart'; // API service file
import '../globals.dart'; // Global variables (e.g., favoriteNotifier)
import '../storage/favorite_storage.dart'; // Local favorite storage management

// Home Screen Stateful Widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// State class for HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  // List of tab labels
  List tabs = ["All", "Category", "Top", "Recommended"];

  // All products fetched from API
  List<dynamic> allProducts = [];

  // Products after applying search filter
  List<dynamic> filteredProducts = [];

  // Loading state
  bool isLoading = true;

  // Text controller for search field
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts(); // Load data when screen starts
  }

  // Function to fetch all products
  void loadProducts() async {
    try {
      final fetchedProducts = await fetchProducts(); // Fetch from API
      setState(() {
        allProducts = fetchedProducts;
        filteredProducts = fetchedProducts; // Initially same
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }
  }

  // Function to filter products while typing
  void filterProducts(String query) {
    List<dynamic> results = [];
    if (query.isEmpty) {
      // If no search input, show all
      results = allProducts;
    } else {
      // Filter based on title, rating, or price
      results = allProducts.where((product) {
        final title = product['title'].toString().toLowerCase();
        final rating = product['rating'].toString().toLowerCase();
        final price = product['price'].toString().toLowerCase();
        final searchQuery = query.toLowerCase();

        return title.contains(searchQuery) ||
            rating.contains(searchQuery) ||
            price.contains(searchQuery);
      }).toList();
    }
    // Update filtered products
    setState(() {
      filteredProducts = results;
    });
  }

  // Function to toggle favorite status
  void toggleFavorite(String productId) async {
    await FavoriteStorage.toggleFavorite(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: Colors.white, // White background
        elevation: 0, // No shadow
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black, // Black text
            fontWeight: FontWeight.w600, // Semi-bold
          ),
        ),
      ),

      // Body starts
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader
          : ValueListenableBuilder<List<String>>(
        valueListenable: favoriteNotifier, // Listen for favorites changes
        builder: (context, favorites, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔍 Search bar + Notification icon row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Search box
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: filterProducts, // Filter as typing
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xfffe6969), // Red search icon
                            ),
                            border: InputBorder.none,
                            label: Text("Find your product"),
                          ),
                        ),
                      ),

                      // Notification icon
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 6,
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: Color(0xfffe6969),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 🖼 Promotional banner
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xfffff0dd), // Light orange bg
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset("assets/images/freed.png"),
                  ),

                  SizedBox(height: 20),

                  // 📌 Tabs section
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.black12.withOpacity(0.05),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  tabs[index],
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20),

                  // 🛍 Horizontal list of products
                  filteredProducts.isEmpty
                      ? Text(
                    "No products found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                      : SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: filteredProducts.reversed.toList().length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product =
                        filteredProducts.reversed.toList()[index];
                        final productId = product['id'].toString();
                        final isFav = favorites.contains(productId);

                        return Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product image with favorite button
                              SizedBox(
                                child: Stack(
                                  children: [
                                    // Product image tap → Product screen
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Productscreen(product: product),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: Image.network(
                                          product['thumbnail'],
                                          fit: BoxFit.cover,
                                          height: 180,
                                          width: 150,
                                        ),
                                      ),
                                    ),

                                    // Favorite button
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: InkWell(
                                        onTap: () {
                                          toggleFavorite(productId);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              isFav
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Color(0xfffe6969),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              // Product title
                              SizedBox(
                                width: 150,
                                child: AutoSizeText(
                                  product['title'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(height: 10),

                              // Rating and price
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  Text('(${product['rating']})'),
                                  SizedBox(width: 10),
                                  Text(
                                    "\$${product['price']}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfffe6969),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 5),

                  // 🆕 Newest Product title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Newest Product",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // 📦 Grid view of products
                  GridView.builder(
                    itemCount: filteredProducts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Disable inner scroll
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final productId = product['id'].toString();
                      final isFav = favorites.contains(productId);

                      return Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product image
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Productscreen(product: product),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        product['thumbnail'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // Favorite icon
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: InkWell(
                                      onTap: () {
                                        toggleFavorite(productId);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Color(0xfffe6969),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),

                            // Product name
                            Text(
                              product['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 10),

                            // Rating + price
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                Text('(${product['rating']})'),
                                SizedBox(width: 10),
                                Text(
                                  "\$${product['price']}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfffe6969),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
