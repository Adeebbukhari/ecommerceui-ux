import 'package:ecommerce/screens/shippingadressscreen.dart'; // Importing shipping address screen
import 'package:ecommerce/widgets/container_button_modal.dart'; // Importing custom button widget
import 'package:flutter/material.dart'; // Flutter material package
import '../api/api_service.dart'; // API service for fetching products

// Stateful widget for Payment Method screen
class PayementMethodScreen extends StatefulWidget {
  // productPrice is used for both: (A) single product buy-now, or (B) cart subtotal when coming from cart
  final double? productPrice; // optional price passed from previous screen
  final bool isFromCart; // flag to check if coming from cart

  // Constructor with optional productPrice and isFromCart flag
  const PayementMethodScreen({Key? key, this.productPrice, this.isFromCart = false}) : super(key: key);

  @override
  State<PayementMethodScreen> createState() => _PayementMethodScreenState(); // creating state
}

class _PayementMethodScreenState extends State<PayementMethodScreen> {
  int _type1 = 1; // selected payment type, default = 1 (UPI)

  double? productPrice; // displayed sub-total or single product price
  double shippingFee = 10.0; // static shipping fee for now

  // function to handle radio button selection
  void _handleRadio(Object? e) => setState(() {
    _type1 = e as int;
  });

  @override
  void initState() {
    super.initState();
    // If a price is passed (either cart subtotal or a single product price), use it.
    if (widget.productPrice != null) {
      productPrice = widget.productPrice;
    } else {
      // Fallback: try to load a product price from API
      _loadProductPrice();
    }
  }

  // function to fetch product price from API if not passed
  Future<void> _loadProductPrice() async {
    try {
      final products = await fetchProducts(); // fetch product list
      if (products.isNotEmpty) {
        final priceFromApi = (products[0]['price'] as num).toDouble();
        setState(() {
          productPrice = priceFromApi; // set price from API
        });
      } else {
        setState(() {
          productPrice = 0.0; // fallback price
        });
      }
    } catch (e) {
      print("Error fetching products: $e");
      setState(() {
        productPrice = 0.0; // fallback on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // get screen size

    double total = (productPrice ?? 0) + shippingFee; // calculate total

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        leading: BackButton(), // default back button
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              // UPI payment option
              Container(
                width: size.width,
                height: 55,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    border: _type1 == 1
                        ? Border.all(width: 1, color: Color(0xfffe6969))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _type1,
                            onChanged: _handleRadio,
                            activeColor: Color(0xfffe6969),
                          ),
                          Text(
                            "UPI",
                            style: _type1 == 1
                                ? TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xfffe6969))
                                : TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xfffe6969)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Credit/Debit Card option
              Container(
                width: size.width,
                height: 55,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    border: _type1 == 2
                        ? Border.all(width: 1, color: Color(0xfffe6969))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _type1,
                            onChanged: _handleRadio,
                            activeColor: Color(0xfffe6969),
                          ),
                          Text(
                            "Credit/Debit Card",
                            style: _type1 == 2
                                ? TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xfffe6969))
                                : TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xfffe6969)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Cash on Delivery option
              Container(
                width: size.width,
                height: 55,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    border: _type1 == 3
                        ? Border.all(width: 1, color: Color(0xfffe6969))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: _type1,
                            onChanged: _handleRadio,
                            activeColor: Color(0xfffe6969),
                          ),
                          Text(
                            "Cash On Delivery",
                            style: _type1 == 3
                                ? TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xfffe6969))
                                : TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xfffe6969)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              // Display Sub-Total
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
                    productPrice != null
                        ? "\$${productPrice!.toStringAsFixed(2)}"
                        : "Loading...",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              // Display Shipping Fee
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
                    "\$${shippingFee.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 30,
                color: Colors.black,
              ),
              // Display Total Payment
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
                    "\$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffe6969)),
                  ),
                ],
              ),
              SizedBox(height: 70),
              // Confirm Payment button
              InkWell(
                onTap: () async {
                  // Navigate to Shipping Address screen
                  final shippingResult = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShippingAdressScreen()),
                  );

                  if (shippingResult != null && shippingResult is Map && shippingResult['paid'] == true) {
                    // bubble success back to caller (CartScreen or ProductScreen)
                    Navigator.pop(context, {'paid': true});
                  } else {
                    // Do nothing, stay on this screen
                  }
                },
                child: ContainerButtonModal(
                  itext: "Confirm Payement",
                  containerWidth: MediaQuery.of(context).size.width,
                  bgcolor: Color(0xfffe6969),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}