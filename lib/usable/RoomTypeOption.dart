import 'package:flutter/material.dart';

class RoomTypeOption extends StatefulWidget {
  final String text;
  final TextStyle tstyle2;

  const RoomTypeOption({super.key,
    required this.text,
    required this.tstyle2,
  });

  @override
  State<RoomTypeOption> createState() => _RoomTypeOptionState();
}

class _RoomTypeOptionState extends State<RoomTypeOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade50,
            blurRadius: 4,
            spreadRadius: 2,
          )
        ],
      ),
      child: Text(widget.text, style: widget.tstyle2),
    );
  }
}
