import 'package:ecommerce/screens/payementmethodscreen.dart';
import 'package:ecommerce/widgets/container_button_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cartscreen extends StatefulWidget {
  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  

  List imageList = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg",
  ];

  List productTitles = [
    "Warm Zipper",
    "Knitted Woo!",
    "Zipper Win",
  ];

  List prices = [
    "\$300",
    "\$650",
    "\$50",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  itemCount: imageList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              splashRadius: 20,
                                activeColor: Color(0xfffe6969),
                                value: true, onChanged: (val){}
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                imageList[index],
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    productTitles[index],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Hooded Jacket",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                    prices[index],
                                  style: TextStyle(
                                    color: Color(0xfffe6969),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(CupertinoIcons.minus, color: Color(0xfffe6969),),
                                SizedBox(width: 20,),
                                Text("1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                                SizedBox(width: 20,),
                                Icon(CupertinoIcons.plus, color: Color(0xfffe6969),),
                              ],
                            )
                          ],
                        ),
                      );
                }),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select All", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                  Checkbox(
                    splashRadius: 20,
                      activeColor: Color(0xfffe6969),
                      value: false, onChanged: (val){}),
                ],
              ),
              Divider(height: 20, thickness: 1,  color: Colors.black,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Payement", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  Text("\$1000.54", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xfffe6969)),),
                ],
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PayementMethodScreen()),);
                },
                child: ContainerButtonModal(itext: "Proceed", containerWidth: MediaQuery.of(context).size.width, bgcolor: Color(0xfffe6969),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
