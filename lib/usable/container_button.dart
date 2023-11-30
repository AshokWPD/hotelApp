import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  final Color? bgColor;
  final double? containerWidth; // Changed to lowercase
  final String text;

  const ContainerButton({
    Key? key, // Added Key? key parameter
    required this.containerWidth, // Changed to lowercase
    this.bgColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: containerWidth, // Use the parameter with lowercase
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
