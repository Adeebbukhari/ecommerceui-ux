import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ecommerce/screens/homescreen.dart';


class Onboardingscreen extends StatelessWidget {

  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w700,),
      bodyTextStyle: TextStyle(fontSize: 19),
      bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,

    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "ShopNow",
          body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
          image: Image.asset("assets/images/splash1.png", width: 200,),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Big Discount",
          body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
          image: Image.asset("assets/images/splash2.png", width: 200,),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Free Delivery",
          body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
          image: Image.asset("assets/images/splash3.png", width: 200,),
          decoration: pageDecoration,
          footer: Padding(padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen(),));
              },
              child: Text("Shop Now", style: TextStyle(color: Colors.white, fontSize: 18),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(55),
                backgroundColor: Color(0xffef6969),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ),
      ],
      showSkipButton: false,
      showDoneButton: false,
      showBackButton: true,
      back: Text("Back", style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffef6969),
      ),
      ),
      next: Text("Next", style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffef6969),
      ),
      ),
      done: Text("Done", style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffef6969),
      ),
      ),
      skip: Text("Skip", style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xffef6969),
      ),
      ),
      onDone: (){},
      // onChange: (){},
      dotsDecorator: DotsDecorator(
        size: Size.square(10),
        activeSize: Size(20, 10),
        color: Colors.black26,
        spacing: EdgeInsets.symmetric(horizontal: 3),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        )
      ),
    );
  }
}
