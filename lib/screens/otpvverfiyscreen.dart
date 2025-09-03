import 'package:ecommerce/screens/recoveryscreen.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Otpvverfiyscreen extends StatefulWidget {
  const Otpvverfiyscreen({super.key});

  @override
  State<Otpvverfiyscreen> createState() => _OtpvverfiyscreenState();
}

class _OtpvverfiyscreenState extends State<Otpvverfiyscreen> with CodeAutoFill {
  // Controller for OTP text input
  TextEditingController textEditingController = TextEditingController(text: "");

  // OTP received from SMS
  String? _receivedOtp;

  // Decoration for the OTP boxes
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  // Get app signature for SMS formatting
  _getSignatureCode() async {
    String? signature = await SmsAutoFill().getAppSignature;
    print("App Signature: $signature");
  }

  // Listen for OTP
  @override
  void codeUpdated() {
    setState(() {
      _receivedOtp = code;
      textEditingController.text = code ?? '';
    });
    print("Received OTP: $_receivedOtp");
  }

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    listenForCode();
  }

  @override
  void dispose() {
    cancel(); // Cancel OTP listening
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 21.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(height: 10),
               Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
               SizedBox(height: 60),
              PinFieldAutoFill(
                controller: textEditingController,
                codeLength: 4,
                decoration: UnderlineDecoration(
                  textStyle:  TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                onCodeChanged: (code) {
                  print("Typed OTP: $code");
                },
              ),
               SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Add OTP verification logic here if needed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecoveryScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:  Size.fromHeight(55),
                  backgroundColor:  Color(0xffef6969),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
