import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String title;
  final bool isSecured;
  final TextEditingController? controller;
  final bool enabled;
  final String? Function(String?)? validator;
  final VoidCallback? togglePasswordVisibility;

  const InputField({
    Key? key,
    required this.title,
    required this.isSecured,
    this.controller,
    this.enabled = true,
    this.validator,
    this.togglePasswordVisibility,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 0),
              color: const Color.fromARGB(255, 241, 241, 241),
            ),
            child: TextFormField(
              obscureText: widget.isSecured && !_isPasswordVisible,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              controller: widget.controller,
              enabled: widget.enabled,
              validator: widget.validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.title,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: widget.isSecured
                    ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                    if (widget.togglePasswordVisibility != null) {
                      widget.togglePasswordVisibility!();
                    }
                  },
                )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

