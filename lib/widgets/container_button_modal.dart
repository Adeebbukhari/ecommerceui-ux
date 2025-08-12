import 'package:flutter/material.dart';

class ContainerButtonModal extends StatelessWidget {
  final Color? bgcolor;
  final double? containerWidth;
  final String itext;

  // ✅ Constructor to accept parameters
  const ContainerButtonModal({
    Key? key,
    this.bgcolor,
    this.containerWidth,
    required this.itext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: containerWidth,
      decoration: BoxDecoration(
        color: bgcolor ?? Colors.blue, // ✅ Use bgcolor if provided
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          itext,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
