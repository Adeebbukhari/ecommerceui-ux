import 'package:ecommerce/screens/productscreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List tabs = [
    "All", "Category", "Top", "Recommended"
  ];

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

  List reviews = [
    "54",
    "120",
    "542",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 50,
                    width: MediaQuery.of(context).size.width/1.5,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 2,
                      )],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xfffe6969),
                        ),
                        border: InputBorder.none,
                        label: Text("Find your product")
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 50,
                    width: MediaQuery.of(context).size.width/6,
                    decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 2,
                      )],
                    ),
                    child: Icon(Icons.notifications, color: Color(0xfffe6969),),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xfffff0dd),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset("assets/images/freed.png"),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index){
                      return FittedBox(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.only(left: 15, right: 15, ),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20,),
              Container(
                height: 272,
                child: ListView.builder(
                  itemCount: imageList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Productscreen()));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        imageList[index],
                                        fit: BoxFit.cover,
                                        height: 180,
                                        width: 150,),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xfffe6969),
                                        ),
                                      ),
                                  ),)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(productTitles[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber,),
                                Text(
                                  '(' + reviews[index] + ')',
                                ),
                                SizedBox(width: 10,),
                                Text(prices[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfffe6969),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 10,),
              Align(

                alignment: Alignment.centerLeft,
                child: Text("Newest Product", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 10,),
              GridView.builder(
                itemCount: imageList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 2,
                  ), itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Productscreen()));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      imageList[index],
                                      ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite,
                                        color: Color(0xfffe6969),
                                      ),
                                    ),
                                  ),)
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(productTitles[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber,),
                              Text(
                                '(' + reviews[index] + ')',
                              ),
                              SizedBox(width: 10,),
                              Text(prices[index],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfffe6969),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
              },),
            ],
          ),
        ),
      ),
    );
  }
}
