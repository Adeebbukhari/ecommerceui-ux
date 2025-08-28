import 'package:ecommerce/widgets/container_button_modal.dart';
import 'package:flutter/material.dart';

import '../screens/cartscreen.dart';

class ProductDetailsPopup extends StatefulWidget {
  @override
  State<ProductDetailsPopup> createState() => _ProductDetailsPopupState();
}

class _ProductDetailsPopupState extends State<ProductDetailsPopup> {
  final iStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Size: ", style: iStyle),
                          SizedBox(height: 20),
                          Text("Color: ", style: iStyle),
                          SizedBox(height: 20),
                          Text("Total: ", style: iStyle),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("S ", style: iStyle),
                              SizedBox(width: 20),
                              Text("M", style: iStyle),
                              SizedBox(width: 20),
                              Text("L", style: iStyle),
                              SizedBox(width: 20),
                              Text("XL", style: iStyle),
                              SizedBox(width: 20),
                              Text("XXL", style: iStyle),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("-", style: iStyle,),
                              SizedBox(width: 30,),
                              Text("1", style: iStyle,),
                              SizedBox(width: 30,),
                              Text("+", style: iStyle,),
                            ],
                          ),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payement : ",
                        style: iStyle,
                      ),
                      Text(
                        "\$40.00",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Cartscreen()));
                    },
                    child: ContainerButtonModal(
                      itext: 'Check Out',
                      bgcolor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: ContainerButtonModal(
        containerWidth: MediaQuery.of(context).size.width / 1.5,
        itext: "Buy Now",
        bgcolor: Colors.red,
      ),
    );
  }
}
