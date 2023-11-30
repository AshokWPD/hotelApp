import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool isSecured;
  final bool enabled;
  final bool showPasswordToggle;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Color backgroundColor;
  final maxlength;
  final TextStyle? errorTextStyle; // Add the errorTextStyle parameter

  const CustomTextField({
    Key? key,
    required this.title,
    this.controller,
    this.isSecured = false,
    this.enabled = true,
    this.showPasswordToggle = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.backgroundColor = const Color.fromARGB(255, 241, 241, 241),
    this.errorTextStyle, this.maxlength, // Initialize the errorTextStyle parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 0),
              color: backgroundColor,
            ),
            child: TextFormField(
              controller: controller,
              obscureText: isSecured,
              enabled: enabled,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: isSecured && showPasswordToggle
                    ? IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Implement password visibility toggle here
                  },
                )
                    : null,
              ),
              keyboardType: keyboardType,
              // maxLength: maxlength,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
