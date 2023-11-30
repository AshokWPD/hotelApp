import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../model/usermodel.dart';
import 'form/ac_fitting_contact_form.dart';
import 'form/electrical_works_contact_form.dart';
import 'form/plumbing_contact_form.dart';

class AdminServicesPage extends StatefulWidget {
   AdminServicesPage({super.key});

  @override
  State<AdminServicesPage> createState() => _AdminServicesPageState();
}



class _AdminServicesPageState extends State<AdminServicesPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfile();
  }

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

User? user;

void fetchProfile() async {
           user = _auth.currentUser;

if (user != null) {
      // User is already logged in, retrieve user data
       userData = await getUserData(user!.uid);
  
    } 
}

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Services Provided by Admin'),
          centerTitle: true,
        backgroundColor:  Colors.white,),
      body: Container(
        decoration: const BoxDecoration(
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Lottie.asset(
                  'images/service.json',
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                Card(
                  margin: const EdgeInsets.all(16.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'List of Services:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextButton(
                         onPressed: () {
                            // Navigate to Electrical Works Contact Form
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AdminsTicket( username: userData!.name, uid: 'false', vendorID: user!.uid, title: 'AC Fitting work'),));
                          },
                          child: Text(
                            'AC Fitting',
                            style: TextStyle(fontSize: 16.0, color: customColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to Electrical Works Contact Form
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AdminsTicket( username: userData!.name, uid: 'false', vendorID: user!.uid, title: 'Electrical work'),));
                          },
                          child: Text(
                            'Electrical Works',
                            style: TextStyle(fontSize: 16.0, color: customColor),
                          ),
                        ),
                        TextButton(
                       onPressed: () {
                            // Navigate to Electrical Works Contact Form
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AdminsTicket( username: userData!.name, uid: 'false', vendorID: user!.uid, title: 'Plumbing work'),));
                          },
                          child: Text(
                            'Plumbing',
                            style: TextStyle(fontSize: 16.0, color: customColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
