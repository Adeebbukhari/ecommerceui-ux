import 'package:ecommerce/screens/payementmethodscreen.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/container_button_modal.dart';
import '../storage/cart_storage.dart';

class Productscreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const Productscreen({Key? key, required this.product}) : super(key: key);

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final count = await CartStorage.getProductCount(widget.product['id'].toString());
    setState(() {
      itemCount = count;
    });
  }

  Future<void> _updateCart(int count) async {
    setState(() {
      itemCount = count;
    });
    await CartStorage.saveProductCount(widget.product['id'].toString(), count);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final List<String> images = List.generate(3, (_) => product['thumbnail']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Overview"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🖼 Carousel
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
                      currentItemShadow: [],
                      sideItemsShadow: [],
                    ),
                  ),
                ),

                // 📝 Title + Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          AutoSizeText(
                            product['title'],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product['brand'] ?? "No Brand",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${product['price']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xfff50303),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ⭐ Rating
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text("(${product['rating']})"),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // 📖 Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product['description'] ?? "No description available",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🛒 Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 🛒 Cart Button
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
                          _updateCart(1);
                        },
                        child: const Icon(
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
                                _updateCart(itemCount - 1);
                              } else {
                                _updateCart(0);
                              }
                            },
                            child: const Icon(Icons.remove, color: Colors.red),
                          ),
                          Text(
                            itemCount.toString(),
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              _updateCart(itemCount + 1);
                            },
                            child: const Icon(Icons.add, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    // 🛒 Buy Now
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
