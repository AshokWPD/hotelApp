
import 'package:flutter/material.dart';

import '../usable/style.dart';
import 'login.dart';
import 'ownerlogin.dart';
import 'userlogin.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  double _dialogHeight = 0.0;
  final double _dialogWidth = 350;
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _dialogHeight = 600; // Set your preferred height
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    Style style = Style();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      height: _dialogHeight,
      width: _dialogWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 6, left: 6),
        child: SingleChildScrollView( // Wrap the Column with a SingleChildScrollView
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Changed to start alignment
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar( // Add AppBar for the close (X) icon
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                const Text(
                  'Join as User/Vendor',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'If you are\'nt registered yet,Then click on the Vendor or User',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () =>
                        _showAnimatedDialog(context, const UserLoginForm()),
                    style: style.btnStyle(
                      btnColor: Colors.white,
                      btnWidth: MediaQuery.of(context).size.width / 2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: customColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Join as User',
                              style: TextStyle(
                                color: customColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'OR',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () =>
                        _showAnimatedDialog(context, const OwnerLoginForm()),
                    style: style.btnStyle(
                      btnColor: Colors.white,
                      btnWidth: MediaQuery.of(context).size.width / 2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.business,
                              color: customColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Join as Vendor',
                              style: TextStyle(
                                color: customColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    _showAnimatedDialog(context, const LoginScreen());
                  },
                  child: Text(
                    "Already SignedUp? SignIn",
                    style: TextStyle(color: customColor, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAnimatedDialog(BuildContext context, var val) {
    Navigator.of(context).pop(); // Close the current dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: val,
        );
      },
    );
  }
}
