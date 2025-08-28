import 'package:ecommerce/screens/shippingadressscreen.dart';
import 'package:ecommerce/widgets/container_button_modal.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';

class PayementMethodScreen extends StatefulWidget {
  final double? productPrice;

  const PayementMethodScreen({Key? key, this.productPrice}) : super(key: key); // CHANGED: constructor

  @override
  State<PayementMethodScreen> createState() => _PayementMethodScreenState();
}

class _PayementMethodScreenState extends State<PayementMethodScreen> {
  int _type1 = 1;

  double? productPrice; // from API or passed-in
  double shippingFee = 10.0; // static for now

  void _handleRadio(Object? e) => setState(() {
    _type1 = e as int;
  });

  @override
  void initState() {
    super.initState();
    // CHANGED: if price is passed from Productscreen, use it; otherwise fallback to API fetch
    if (widget.productPrice != null) {
      productPrice = widget.productPrice;
    } else {
      _loadProductPrice();
    }
  }

  Future<void> _loadProductPrice() async {
    try {
      final products = await fetchProducts();
      // Example: take the first product’s price
      final priceFromApi = (products[0]['price'] as num).toDouble();

      setState(() {
        productPrice = priceFromApi;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double total = (productPrice ?? 0) + shippingFee;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShippingAdressScreen()),
                  );
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
