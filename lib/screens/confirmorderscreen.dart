import 'package:ecommerce/screens/ordersuccessscreen.dart';
import 'package:ecommerce/screens/payementmethodscreen.dart';
import 'package:ecommerce/screens/shippingadressscreen.dart';
import 'package:flutter/material.dart';

import '../widgets/container_button_modal.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confrim Order "),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  "Shipping Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 130,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dear Customer", style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ShippingAdressScreen()));
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
                      Text("02 Lovely", style: TextStyle(fontSize: 16)),
                      Text(
                        "juhapura, Ahmedabad, Gujarat, India, 380055",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payement Method",
                        style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    TextButton(
                      onPressed: () {
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
                SizedBox(height: 5,),
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
                      child: Image.asset("assets/images/Visa.png"),
                    ),
                    SizedBox(width: 10,),
                    Text("**** **** **** 5110")
                  ],
                ),
                SizedBox(height: 40,),
                Text("Delivery Method",
                      style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                SizedBox(height: 10,),
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
                      child: Image.asset("assets/images/icon3.png"),
                    ),
                    Text("2-7 Days",
                      style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sub-Total", style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),),
                    Text("\$1000.54", style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,

                    ),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping Fee", style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),),
                    Text("\$10", style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                Divider(
                  height: 30,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Payement", style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),),
                    Text("\$1010.54", style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffe6969)
                    ),),
                  ],
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderSuccessScreen()));
                  },
                  child: ContainerButtonModal(itext: "Confirm Order", containerWidth: MediaQuery.of(context).size.width, bgcolor: Color(0xfffe6969),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
