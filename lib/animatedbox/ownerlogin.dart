import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/model/usermodel.dart';
import '../usable/TextField.dart';
import '../usable/input_field.dart';


class OwnerLoginForm extends StatefulWidget {
  const OwnerLoginForm({super.key,});


  @override
  _OwnerLoginFormState createState() => _OwnerLoginFormState();
}

class _OwnerLoginFormState extends State<OwnerLoginForm> {
  double _dialogHeight = 0.0;
  final double _dialogWidth = 400;
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerEmailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController = TextEditingController();

  String ownerName = '';
  String ownerEmail = '';
  String phoneNumber = '';
  String password = '';
  String reEnterPassword = '';

  final _formkey = GlobalKey<FormState>();

//Register
Future<void> registerOwner({
  required String name,
  required String email,
  required String password,
  required String mobile,
  required String type,
  required String address,
  required double latitude,
  required double longitude,
  required String city,
  required bool isAllowed, // Include "isAllowed" field
  required String pincode,
}) async {
  try {
    User? existingUser = await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(email)
        .then((methods) {
      if (methods.isNotEmpty) {
        return FirebaseAuth.instance.currentUser;
      }
      return null;
    });

    if (existingUser != null) {
      showToast('User already exist...',Colors.red);
    }
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

    if (user != null) {
      // Create a User Model
      UserModel userModel = UserModel(
        name: name,
        email: email,
        mobile: mobile,
        type: type,
        address: address,
        latitude: latitude,
        longitude: longitude,
        city: city,
        isAllowed: isAllowed, // Set isAllowed
        pincode: pincode, vendorId: '',
      );

      // Store the user data in Cloud Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap());

      // Registration successful
    }} on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      showToast('User already exist...',Colors.red);
    } else {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      showToast('Somthing went wrong...',Colors.red);
    }
  } catch (e) {
    // Handle registration errors
    print(e.toString());
  }
}

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _dialogHeight = 720;
      });
    });

    _ownerNameController.addListener(() {
      setState(() {
        ownerName = _ownerNameController.text;
      });
    });

    _ownerEmailController.addListener(() {
      setState(() {
        ownerEmail = _ownerEmailController.text;
      });
    });

    _phoneNumberController.addListener(() {
      setState(() {
        phoneNumber = _phoneNumberController.text;
      });
    });


    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });

    _reEnterPasswordController.addListener(() {
      setState(() {
        reEnterPassword = _reEnterPasswordController.text;
      });
    });
  }

  @override
  void dispose() {
    _ownerNameController.dispose();
    _ownerEmailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color==Colors.black?Colors.white: Colors.black,
    );
  }

  /*Future<void> ownerRegistration() async {
    if (_formkey.currentState!.validate()) {
      var request = http.MultipartRequest('POST', Uri.parse('https://absolutestay.co.in/api/vendor_registration'));

      request.fields['name'] = ownerName;
      request.fields['email'] = ownerEmail;
      request.fields['mobile'] = phoneNumber;
      request.fields['login_type'] = 'vendor';
      request.fields['password'] = password;

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          showToast('Registration successful');
        } else {
          showToast('Registration failed. Please try again.');
        }
      } catch (e) {
        showToast('Network error. Please check your internet connection.');
      }
      Navigator.pop(context);
    } else {
      showToast('Fill all fields');
    }
  }*/


  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close, color: customColor),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      'Vendor Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Unlock More Bookings, Elevate Your Business!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                  title: 'Vendor Name',
                  isSecured: false,
                  controller: _ownerNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vendor Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                  title: 'Vendor Email',
                  isSecured: false,
                  controller: _ownerEmailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                CustomTextField(
                  title: 'Phone Number',
                  controller: _phoneNumberController,
                  isSecured: false,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  errorTextStyle: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                  title: 'Password',
                  isSecured: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6 ) {
                      return 'Password must be atleast 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                  title: 'Re-Enter Password',
                  isSecured: true,
                  controller: _reEnterPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Re-enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        if (_formkey.currentState!.validate()) {
                          registerOwner(name: _ownerNameController.text, 
                          email: _ownerEmailController.text,
                           password: _passwordController.text,
                            mobile: _phoneNumberController.text, 
                            type: 'owner',
                             address: 'Address',
                              latitude: 0.0,
                               longitude: 0.0, 
                               city: 'city', 
                               isAllowed: true,
                                pincode: 'pincode');
                          showToast('Registered Successfully',Colors.black);
                        }else{
                          showToast('Can\'t Register, Fill All Fields',Colors.red);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromRGBO(33, 37, 41, 1.0);
                            }
                            return const Color.fromRGBO(33, 84, 115, 1.0);
                          },
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

