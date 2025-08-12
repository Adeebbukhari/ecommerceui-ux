import 'package:ecommerce/screens/navigationscreen.dart';
import 'package:flutter/material.dart';

import '../widgets/container_button_modal.dart';

class OrderSuccessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/success.png"),
            SizedBox(height:15,),
            Text("Success!", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 1),),
            SizedBox(height:5,),
            Text("Your Order will be delivered soon ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            Text("Thank You For Chosing Us", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            SizedBox(height: 40),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NavigationScreen()));
              },
              child: ContainerButtonModal(itext: "Continue Shopping", containerWidth: MediaQuery.of(context).size.width, bgcolor: Color(0xfffe6969),),
            )
          ],
        ),
    );
  }
}
