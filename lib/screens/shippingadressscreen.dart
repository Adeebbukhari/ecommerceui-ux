import 'package:ecommerce/widgets/container_button_modal.dart';
import 'package:flutter/material.dart';

import 'confirmorderscreen.dart';

class ShippingAdressScreen extends StatelessWidget {
  const ShippingAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Shipping Address"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Full Name")
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Address")
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("City")
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("State/Province")
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Country")
                      ),
                    ),
                    SizedBox(height: 25,),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("ZipCode.")
                      ),
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmOrderScreen()));
                      },
                        child: ContainerButtonModal(
                          itext: "Save Address",
                          bgcolor: Color(0xfffe6969),
                          containerWidth: MediaQuery.of(context).size.width,),
                    )
                  ],
                ),
            ),
        ),
      ),
    );
  }
}
