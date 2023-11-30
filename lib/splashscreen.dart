import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/model/Maindata.dart';
import 'NetworkCheckScreen.dart';
import 'home/homepage.dart';
import 'model/usermodel.dart';
import 'owner/addProperty.dart';
import 'sub_vendor/sub_vendor_homepage.dart';
import 'user/user_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _navigateToScreen();
  }
   void checkUserStatus() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // User is already logged in, retrieve user data
      UserModel? userData = await getUserData(user.uid);
setState(() {
  MainData().UserUID=user.uid;
});
      if (userData != null) {
        navigateByUserType(userData.type);
      } else {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));      }
    } else {
      // User is not logged in, navigate to the login screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
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


  void navigateByUserType(String userType) {
    switch (userType) {
      case 'user':
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserHomePage(),
        ));
        break;
      case 'owner':
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AddProperty(),
        ));
        break;
      case 'vendor':
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SubVendorHomePage(),
        ));
        break;
      default:
Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));        break;
    }
  }



  Future<void> _navigateToScreen() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    await Future.delayed(const Duration(seconds: 2));
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NetworkCheckScreen(),
        ),
      );
    } else {
      checkUserStatus();
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const HomePage(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color brightWhite = Colors.white.withRed(255).withGreen(255).withBlue(255);

    return Container(
      color: brightWhite,
      child: Center(
        child: Image.asset(
          'images/splash.jpg',
          width: 300,
          height: 350,
        ),
      ),
    );
  }
}
