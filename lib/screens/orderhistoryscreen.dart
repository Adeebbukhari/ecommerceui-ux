import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
    ),
      body:Center(child: Text("Page Will be added after the Backend is prepared.")),
    );
  }
}
