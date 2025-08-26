import 'package:ecommerce/widgets/product_details_popup.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Productscreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const Productscreen({Key? key, required this.product}) : super(key: key);

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // 👇 Repeat thumbnail 3 times so carousel works even with one image
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
                // 🖼 Carousel for product images
                Container(
                  color: Colors.transparent, // or use your page’s background color
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FanCarouselImageSlider.sliderType2(
                      imagesLink: images,
                      isAssets: false,
                      autoPlay: true,
                      sliderHeight: 430,
                      imageFitMode: BoxFit.contain,
                      currentItemShadow: [],       // ⬅ removes center image shadow
                      sideItemsShadow: [],         // ⬅ removes side image shadows
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
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // ⭐ Rating
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

                // 📖 Description
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

                // 🛒 Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Color(0xfffe6969),
                      ),
                    ),
                    ProductDetailsPopup(),
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
