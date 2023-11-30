import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/user/user_ticket.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/bookingModel.dart';
import '../model/ticketModel.dart';
import '../model/usermodel.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  List<BookingModel> bookingHistory = [];
      final FirebaseAuth _auth = FirebaseAuth.instance;
bool _isfetching=false;
Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);


Future<List<BookingModel>> getBookingHistory(String userId) async {
  try {
    // Specify the Firestore collection path
    CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

    // Query the collection for bookings with the specified user ID
    QuerySnapshot querySnapshot = await bookings.where('user_id', isEqualTo: userId).get();

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


Future<void> fetchBookingHistoryData() async {
            User? user =_auth.currentUser;
if (user != null) {

    // Fetch the booking history data and update the state
    final List<BookingModel> fetchedBookingHistory = await getBookingHistory(user.uid);
    setState(() {
      bookingHistory = fetchedBookingHistory;
      _isfetching=true;
    });
}
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookingHistoryData();
    fetchProfile();
  }

   void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color!=Colors.black?Colors.black: Colors.white,
    );
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        centerTitle: true,
        backgroundColor:  Colors.white,
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            _isfetching? SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
      
                child: Flex(
                 direction: Axis.vertical,
                  children: [
                              ListView.builder(
                                shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                itemCount: bookingHistory.length,
                                itemBuilder: (BuildContext context,int index) {
                                  var item=bookingHistory[index];
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
                                                const Icon(Icons.hotel_sharp),
                                                const SizedBox(width: 3,),
                                                Text(item.PropertyName,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                              ],
                                            )),
                                            Positioned(top: 45,right: 3,left: 210,
                                            child: Text(' ₹ ${item.priceAmount}',style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
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
                                            Positioned(bottom: 15,right: 15,
                                              child: GestureDetector(
                                                onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => UserTicket(propertID: item.propertyId, username: userData!.name, uid: user!.uid, vendorID: item.vendorId,),));
      
                                                },
                                                child: Icon(Icons.report_problem_sharp,color: Colors.red,)))
                                            
                                      ]),
                                    ),
                                  );
                                
                               }),
                   
                              const SizedBox(height: 25.0),
                            ],
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
