import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../model/usermodel.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
UserModel? userData;
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
  bool _isEditing = false;
  bool isfetching = false;
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color==Colors.black?Colors.white: Colors.black,
    );
  }

Future<void> updateUserDetails(String uid, String name, String mobile, String address, String city, String pincode) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
      'mobile': mobile,
      'address': address,
      'city': city,
      'pincode': pincode,
    });
  } catch (e) {
    print('Error updating user details: $e');
    // Handle the error as needed
  }
}


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    fetchProfile();
    
  }





// profileModel? data;
void fetchProfile() async {
          User? user = _auth.currentUser;

if (user != null) {
      // User is already logged in, retrieve user data
       userData = await getUserData(user.uid);


         setState(() {
        _nameController.text=userData!.name;
        _emailController.text=userData!.email;
        _mobileController.text=userData!.mobile;
        _addressController.text=userData!.address;
        _cityController.text=userData!.city;
        _pincodeController.text=userData!.pincode;
        isfetching=true;
       });
    } else {
        setState(() {
        _nameController.text='';
        _emailController.text='';
        _mobileController.text='';
        _addressController.text='';
        _cityController.text='';
        _pincodeController.text='';
       });
      showToast('Somthing went wrong...',Colors.red);

  
    } 
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:!isfetching
            ? const Center(child: SizedBox(child: CircularProgressIndicator()))
            : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipOval(
              child: Lottie.asset(
                'images/profile.json', // Replace with your animation file path
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 30.0),
            // buildEditableField(
            //   title: 'User ID',
            //   controller: _userIdController,
            // ),
            const SizedBox(height: 15.0),
            buildEditableField(
              title: 'Name',
              controller: _nameController, isenable: _isEditing,

            ),
            const SizedBox(height: 15.0),
            buildEditableField(
              title:  'Email',
              controller: _emailController, isenable: false,
            ),
            const SizedBox(height: 15.0),
            buildEditableField(
              title: 'Mobile',
              controller: _mobileController, isenable: _isEditing,
            ),
            const SizedBox(height: 15.0),
            buildEditableField(
              title: 'Address',
              controller: _addressController, isenable: _isEditing,
            ),
            const SizedBox(height: 15.0),
            buildEditableField(
              title: 'City',
              controller: _cityController, isenable: _isEditing,
            ),
            const SizedBox(height: 15.0),
            buildEditableField(
              title: 'Pincode',
              controller: _pincodeController, isenable: _isEditing,
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Toggle editing mode
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromRGBO(33, 84, 115, 1.0);
                        }
                        return const Color.fromRGBO(33, 37, 41, 1.0);
                      },
                    ),
                  ),
                  child: Text(_isEditing ? 'Cancel' : 'Edit', style: const TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _isEditing
                      ? () async {
                        updateUserDetails(
                          FirebaseAuth.instance.currentUser!.uid,
                         _nameController.text,
                          _mobileController.text,
                           _addressController.text,
                            _cityController.text,
                             _pincodeController.text);
                    showToast('Profile Updated Successfully',Colors.black);
                    /* Perform save operation here */

                    // Disable editing mode after saving
                    setState(() {
                      _isEditing = false;
                    });
                  }
                      : null, // Disable the button if not editing
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
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField({
    required String title,
    required TextEditingController controller,
   required bool isenable,
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
          child: TextFormField(
            controller: controller,
            enabled: isenable, // Enable or disable the text field based on the editing mode
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
