import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../animatedbox/forgetpassword.dart';
import '../animatedbox/login_options.dart';
import '../model/usermodel.dart';
import '../owner/addProperty.dart';
import '../sub_vendor/sub_vendor_homepage.dart';
import '../user/user_home.dart';

class ProfileLoginScreen extends StatefulWidget {
  const ProfileLoginScreen({super.key});

  @override
  _ProfileLoginScreenState createState() => _ProfileLoginScreenState();
}

class _ProfileLoginScreenState extends State<ProfileLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  bool _isPasswordVisible = false;
  bool _isEmailValid = true;
  String UserType = '';

   Future<User?> loginUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

     if (user != null) {
              showToast("Login success!", Colors.green);

           return user;
      } else {
        showToast("Email Not Found!", Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("Email Not Found!", Colors.red);
      } else if (e.code == 'wrong-password') {
        showToast("Wrong Password!", Colors.red);
      } else {
        showToast("Email Not Found!", Colors.red);
      }

  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<UserModel?> getUserData(String uid) async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (userSnapshot.exists) {
      return UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
    } else {
      return null; // User not found
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

// Example login and data retrieval usage
void loginAndRetrieveData() async {
  String email = _emailController.text; // Replace with user's email
  String password = _passwordController.text;    // Replace with user's password

  // Login with email and password
  User? user = await loginUser(email, password);

  if (user != null) {
    // User is logged in, retrieve user data
    UserModel? userData = await getUserData(user.uid);

    if (userData != null) {
      print('User Name: ${userData.name}');
      print('User Mobile: ${userData.mobile}');
 if (userData.type== 'user') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const UserHomePage(), // Replace with your user page
        ),
      );
    } else if (userData.type== 'owner') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const AddProperty(), // Replace with your owner page
        ),
      );
    } else if (userData.type== 'vendor') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              SubVendorHomePage(), // Replace with your vendor page
        ),
      );
    }
      // Access other user data as needed
    } else {
      print('User data not found.');
    }
  } else {
    print('Login failed.');
  }
}

//   Future<User?> loginUser(String email, String password) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);

//     User? user = userCredential.user;

//     return user;
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }

// Future<UserModel?> getUserData(String uid) async {
//   try {
//     DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get();

//     if (userSnapshot.exists) {
//       return UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
//     } else {
//       return null; // User not found
//     }
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }

// // Example login and data retrieval usage
// void loginAndRetrieveData() async {
//   String email = _emailController.text; // Replace with user's email
//   String password = _passwordController.text;    // Replace with user's password

//   // Login with email and password
//   User? user = await loginUser(email, password);

//   if (user != null) {
//     // User is logged in, retrieve user data
//     UserModel? userData = await getUserData(user.uid);

//     if (userData != null) {
//       print('User Name: ${userData.name}');
//       print('User Mobile: ${userData.mobile}');
//  if (userData.type== 'user') {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               const UserHomePage(), // Replace with your user page
//         ),
//       );
//     } else if (userData.type== 'owner') {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               const AddProperty(), // Replace with your owner page
//         ),
//       );
//     } else if (userData.type== 'vendor') {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               SubVendorHomePage(), // Replace with your vendor page
//         ),
//       );
//     }
//       // Access other user data as needed
//     } else {
//       print('User data not found.');
//     }
//   } else {
//     print('Login failed.');
//   }
// }

void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color==Colors.black?Colors.white: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, bottom: 20.0, left: 15.0, right: 15.0),
          child: Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ClipOval(
                        child: Lottie.asset(
                          'images/profile.json',
                          // Replace with your animation file path
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextField(
                        cursorColor: customColor,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          // Title or label text
                          hintText: 'Email',
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          // Adjust padding as needed
                          errorText: _isEmailValid
                              ? null
                              : 'Enter a valid email address',
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: customColor,
                            ),
                          ),
                          labelStyle: const TextStyle(color: Colors.black),
                          // Change the label text color here
                          hintStyle: const TextStyle(
                              color: Colors
                                  .grey), // Change the hint text color here
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _isEmailValid = value.contains('@');
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        cursorColor: customColor,
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        // Control the visibility of the password
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: customColor,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: customColor),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible =
                                    !_isPasswordVisible; // Toggle the visibility state
                              });
                            },
                          ),
                          labelStyle: const TextStyle(color: Colors.black),
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showAnimatedDialog(context, const ForgotPassword());
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 24.0),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: customColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _handleLogin(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return const Color.fromRGBO(
                                        33, 37, 41, 1.0);
                                  }
                                  return const Color.fromRGBO(33, 84, 115, 1.0);
                                },
                              ),
                            ),
                            child: const Text(
                              'SignIn',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      TextButton(
                        onPressed: () async {
                          _showAnimatedDialog(context, const LoginOptions());
                        },
                        child: Text(
                          "New User? SignUp",
                          style: TextStyle(color: customColor, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableField({
    required String title,
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator, // Add the validator parameter
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.transparent, width: 0),
            color: const Color.fromARGB(255, 241, 241, 241),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  obscureText: isPassword && !_isPasswordVisible,
                  validator: validator,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title,
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              if (isPassword)
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAnimatedDialog(BuildContext context, var val) {
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

  void _handleLogin(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: const Text('Email and password fields cannot be empty.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: customColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      loginAndRetrieveData();
    }/* if (_emailController.text == 'user@gmail.com' &&
        _passwordController.text == 'user') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const UserHomePage(), // Replace with your user page
        ),
      );
    } else if (_emailController.text == 'owner@gmail.com' &&
        _passwordController.text == 'owner') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const AddProperty(), // Replace with your owner page
        ),
      );
    } else if (_emailController.text == 'vendor@gmail.com' &&
        _passwordController.text == 'vendor') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              SubVendorHomePage(), // Replace with your vendor page
        ),
      );
    } */else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: const Text('Invalid email or password.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: customColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  /*void _handleLogin(BuildContext context) async {
    final String username = _emailController.text;
    final String password = _passwordController.text;

    final Map<String, String> requestBody = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse('https://absolutestay.co.in/api/login'),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final String userType = responseData['login_type'];

        if (userType == 'user') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserHomePage(),
            ),
          );
        } else if (userType == 'vendor') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AddProperty(),
            ),
          );
        }
      } else {
        if (response.statusCode == 401) {
          showToast('Invalid username or password');
        } else {
          // Handle other error status codes as needed
          // ...
        }
      }
    } catch (error) {
      showToast('Network error: $error');
    }
  }*/

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
