import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/bookingModel.dart';
import '../model/usermodel.dart';

class TenantListPage extends StatefulWidget {
  const TenantListPage({Key? key}) : super(key: key);

  @override
  _TenantListPageState createState() => _TenantListPageState();
}

class _TenantListPageState extends State<TenantListPage> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  // final List<Tenant> tenantList = [
  //   Tenant('John Doe', '555-123-4567', 'john@example.com'),
  //   Tenant('Jane Smith', '555-987-6543', 'jane@example.com'),
  //   Tenant('Bob Johnson', '555-555-5555', 'bob@example.com'),
  //   Tenant('Alice Brown', '555-111-2222', 'alice@example.com'),
  //   // Add more tenants here with unique data
  // ];

   List<BookingModel> tenentList = [];
      final FirebaseAuth _auth = FirebaseAuth.instance;
bool _isfetching=false;


Future<List<BookingModel>> getTenantList(String userId) async {
  try {
    // Specify the Firestore collection path
    CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

    // Query the collection for bookings with the specified user ID
    QuerySnapshot querySnapshot = await bookings.where('vendor_id', isEqualTo: userId).get();

    // Convert the query snapshot to a list of BookingModel instances
    List<BookingModel> userBookings = querySnapshot.docs
        .map((doc) => BookingModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    showToast("Booking History", Colors.green);

    return userBookings;
  } catch (e) {
        showToast("Booking History", Colors.red);

    print('Error fetching booking history: $e');
    // Handle the error as needed
    return [];
  }
}


Future<void> fetchtenentdetail() async {
            User? user =_auth.currentUser;
if (user != null) {

    // Fetch the booking history data and update the state
    final List<BookingModel> fetchedBookingHistory = await getTenantList(user.uid);
    setState(() {
      tenentList = fetchedBookingHistory;
      _isfetching=true;
    });
}
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchtenentdetail();
    fetchProfile();
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
     void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color!=Colors.black?Colors.black: Colors.white,
    );}
  

  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant List'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            _isfetching? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Flex(
                       direction: Axis.vertical,
                        children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                      itemCount: tenentList.length,
                                      itemBuilder: (BuildContext context,int index) {
                                        var item=tenentList[index];
                                        print(item.userId);
                                                
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            
                                           height: height*0.2,
                                           width: double.infinity,
                                           decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(17),
                                           boxShadow:[BoxShadow(
                                              color: Colors.grey.withOpacity(0.5), 
                                              spreadRadius: 4, 
                                              blurRadius: 7, 
                                              offset: const Offset(0, 3), 
                                            )]),
                                            clipBehavior: Clip.antiAlias, // This property clips the child to the rounded corners
                                        
                                            child: Stack(fit:StackFit.passthrough,
                                              children: [
                                              Positioned(left: 0,top: 0,bottom: 0,right: 180,
                                                child: Image.network(item.propertyImages,fit: BoxFit.fill,)),
                                                Positioned(top: 7,right: 3,left: 210,
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.person_2_sharp),
                                                      const SizedBox(width: 3,),
                                                      Text(item.userName,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                                    ],
                                                  )),
                                                  Positioned(top: 45,right: 3,left: 210,
child: Row(
                                              children: [
                                                const Icon(Icons.hotel_sharp),
                                                const SizedBox(width: 3,),
                                                Text(item.PropertyName,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                              ],
                                            )),
                                                    Positioned(top: 80,right: 3,left: 210,
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.location_pin,size: 20,),
                                                      Text(item.location,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                                    ],
                                                  )),
                                                   Positioned(top: 110,right: 3,left: 210,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                    children: [
                                                      const Icon(Icons.calendar_month_sharp,size: 20,),
                                                      Text(item.checkinDate,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                    ],
                                                  ), const SizedBox(height: 4,),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.calendar_month_sharp,size: 20,),
                                                      Text(item.checkoutDate,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                    ],
                                                  )
                                                    ],
                                                  )),
                                              //     Positioned(bottom: 15,right: 15,
                                              //       child: GestureDetector(
                                              //         onTap: () {
                                              // // Navigator.push(context, MaterialPageRoute(builder:(context) => UserTicket(propertID: item.propertyId, username: userData!.name, uid: user!.uid, vendorID: item.vendorId,),));
                
                                              //         },
                                              //         child: Icon(Icons.report_problem_sharp,color: Colors.red,)))
                                                  
                                            ]),
                                          ),
                                        );
                                      
                                     }),
                         
                                    const SizedBox(height: 25.0),
                                  ],
                      ),
                    ],
                  ),
                ),
              ),
            ):Column(
           children: [
            SizedBox(height:height/3 ,),
             Center(
               child:  LoadingAnimationWidget.staggeredDotsWave(
              color:customColor,
              size: 50,
        ),
             ),
           ],
         )
          ],
        ),
      ),
    );
  }
}

  // void _addTenant(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Add Tenant'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             TextField(
  //               controller: nameController,
  //               decoration: const InputDecoration(labelText: 'Name'),
  //             ),
  //             const SizedBox(height: 8.0), // Add spacing between name and phone number
  //             TextField(
  //               controller: phoneController,
  //               decoration: const InputDecoration(labelText: 'Phone'),
  //             ),
  //             const SizedBox(height: 8.0), // Add spacing between phone number and email
  //             TextField(
  //               controller: emailController,
  //               decoration: const InputDecoration(labelText: 'Email'),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Cancel',
  //               style: TextStyle(color: customColor,),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Add',
  //               style: TextStyle(color: customColor,),
  //             ),
  //             onPressed: () {
  //               // Implement logic to add a new tenant here
  //               setState(() {
  //                 tenantList.add(
  //                   Tenant(
  //                     nameController.text,
  //                     phoneController.text,
  //                     emailController.text,
  //                   ),
  //                 );
  //               });
  //               nameController.clear();
  //               phoneController.clear();
  //               emailController.clear();
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

//   void _editTenant(BuildContext context, Tenant tenant, int index) {
//     nameController.text = tenant.name;
//     phoneController.text = tenant.phoneNumber;
//     emailController.text = tenant.email;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Edit Tenant Details'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               const SizedBox(height: 8.0), // Add spacing between name and phone number
//               TextField(
//                 controller: phoneController,
//                 decoration: const InputDecoration(labelText: 'Phone'),
//               ),
//               const SizedBox(height: 8.0), // Add spacing between phone number and email
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel',
//                 style: TextStyle(color: customColor,),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Save',
//                 style: TextStyle(color: customColor,),
//               ),
//               onPressed: () {
//                 // Implement logic to edit tenant information here
//                 setState(() {
//                   tenantList[index] = Tenant(
//                     nameController.text,
//                     phoneController.text,
//                     emailController.text,
//                   );
//                 });
//                 nameController.clear();
//                 phoneController.clear();
//                 emailController.clear();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class Tenant {
//   final String name;
//   final String phoneNumber;
//   final String email;

//   Tenant(this.name, this.phoneNumber, this.email);
// }
