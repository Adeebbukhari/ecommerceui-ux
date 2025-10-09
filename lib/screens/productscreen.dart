// Importing the payment method screen for Buy Now navigation
import 'package:ecommerce/screens/payementmethodscreen.dart';

// Importing image carousel slider package
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

// Importing Flutter Material package
import 'package:flutter/material.dart';

// AutoSizeText package to fit long text in limited space
import 'package:auto_size_text/auto_size_text.dart';

// Importing custom button widget
import '../widgets/container_button_modal.dart';

// Importing cart storage to save/manage cart items
import '../storage/cart_storage.dart';

// Stateful widget because product count in cart is mutable
class Productscreen extends StatefulWidget {
  // Receiving product data as a map
  final Map<String, dynamic> product;

  const Productscreen({Key? key, required this.product}) : super(key: key);

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

// State class for Productscreen
class _ProductscreenState extends State<Productscreen> {
  int itemCount = 0; // Number of items in cart

  @override
  void initState() {
    super.initState();
    _loadCart(); // Load current product count from storage
  }

  // Load current cart count for this product
  Future<void> _loadCart() async {
    final count = await CartStorage.getProductCount(widget.product['id'].toString());
    setState(() {
      itemCount = count;
    });
  }

  // Update cart with new count and save in storage
  Future<void> _updateCart(int count) async {
    setState(() {
      itemCount = count;
    });
    await CartStorage.saveProductCount(widget.product['id'].toString(), count);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product; // Current product
    final List<String> images = List.generate(3, (_) => product['thumbnail']); // Dummy images list for carousel

    return Scaffold(
      // AppBar with back button
      appBar: AppBar(
        title: Text("Product Overview"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      // Scrollable body
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🖼 Product Image Carousel
                Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FanCarouselImageSlider.sliderType2(
                      imagesLink: images,
                      isAssets: false,
                      autoPlay: true,
                      sliderHeight: 430,
                      imageFitMode: BoxFit.contain,
                      currentItemShadow: [], // No shadow
                      sideItemsShadow: [], // No shadow
                    ),
                  ),
                ),

                // 📝 Product Title, Brand & Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          AutoSizeText(
                            product['title'],
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            product['brand'] ?? "No Brand",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${product['price']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xfff50303),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // ⭐ Product Rating
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text("(${product['rating']})"),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // 📖 Product Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product['description'] ?? "No description available",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // 🛒 Actions: Add to Cart & Buy Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 🛒 Add to Cart button with dynamic count
                    Container(
                      height: 60,
                      width: itemCount == 0 ? 60 : 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: itemCount == 0
                          ? InkWell(
                        onTap: () {
                          _updateCart(1); // Add first item
                        },
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color(0xfffe6969),
                        ),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (itemCount > 1) {
                                _updateCart(itemCount - 1); // Reduce count
                              } else {
                                _updateCart(0); // Remove from cart
                              }
                            },
                            child: Icon(Icons.remove, color: Colors.red),
                          ),
                          Text(
                            itemCount.toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              _updateCart(itemCount + 1); // Increase count
                            },
                            child: Icon(Icons.add, color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    // 🛒 Buy Now button
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayementMethodScreen(
                              productPrice: (product['price'] as num).toDouble(),
                            ),
                          ),
                        );
                      },
                      child: ContainerButtonModal(
                        containerWidth: MediaQuery.of(context).size.width / 1.6,
                        itext: "Buy Now",
                        bgcolor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
