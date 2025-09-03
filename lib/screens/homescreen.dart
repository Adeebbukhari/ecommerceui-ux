import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/screens/productscreen.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../globals.dart';
import '../storage/favorite_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tabs = ["All", "Category", "Top", "Recommended"];
  List<dynamic> allProducts = [];     // Original products
  List<dynamic> filteredProducts = []; // Filtered for search
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    try {
      final fetchedProducts = await fetchProducts();
      setState(() {
        allProducts = fetchedProducts;
        filteredProducts = fetchedProducts; // initially same
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // 🔎 Filter function
  void filterProducts(String query) {
    List<dynamic> results = [];
    if (query.isEmpty) {
      results = allProducts;
    } else {
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
    setState(() {
      filteredProducts = results;
    });
  }

  // 🔥 Toggle favorite
  void toggleFavorite(String productId) async {
    await FavoriteStorage.toggleFavorite(productId);
    // ❌ no need to call setState() here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<List<String>>(
        valueListenable: favoriteNotifier,
        builder: (context, favorites, _) {
          return SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔍 Search + Notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          onChanged: filterProducts, // 🔑 filter as typing
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xfffe6969),
                            ),
                            border: InputBorder.none,
                            label: Text("Find your product"),
                          ),
                        ),
                      ),
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
                        child: Icon(Icons.notifications,
                            color: Color(0xfffe6969)),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 🖼 Banner
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xfffff0dd),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset("assets/images/freed.png"),
                  ),

                  SizedBox(height: 20),

                  // 📌 Tabs
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

                  // 🛍 Horizontal Products
                  filteredProducts.isEmpty
                      ? Text("No products found",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red))
                      : SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount:
                      filteredProducts.reversed.toList().length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = filteredProducts
                            .reversed
                            .toList()[index];
                        final productId =
                        product['id'].toString();
                        final isFav =
                        favorites.contains(productId);

                        return Container(
                          margin:
                          EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Productscreen(
                                                        product:
                                                        product)));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(
                                            10),
                                        child: Image.network(
                                          product['thumbnail'],
                                          fit: BoxFit.cover,
                                          height: 180,
                                          width: 150,
                                        ),
                                      ),
                                    ),
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
                                            BorderRadius
                                                .circular(20),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              isFav
                                                  ? Icons.favorite
                                                  : Icons
                                                  .favorite_border,
                                              color:
                                              Color(0xfffe6969),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 150,
                                child: AutoSizeText(
                                  product['title'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber),
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

                  SizedBox(height: 10),

                  // 🆕 Newest Product
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Newest Product",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // 📦 Grid Products
                  GridView.builder(
                    itemCount: filteredProducts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
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
                                                  Productscreen(
                                                      product: product)));
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      child: Image.network(
                                        product['thumbnail'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
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
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
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
