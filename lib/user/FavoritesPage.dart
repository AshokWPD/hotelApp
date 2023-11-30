import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/bookingModel.dart';
import '../model/favModel.dart';
import '../model/propertyModel.dart';
import '../model/usermodel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
 
  List<FavoritePropertyModel> favoriteProperties = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
bool _isfetching=false;
Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
 
Future<List<FavoritePropertyModel>> getFavoritesWithProperties(String userId) async {
  try {
    CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');
    CollectionReference properties = FirebaseFirestore.instance.collection('Property');

    // Query the collection for favorites with the specified user ID
    QuerySnapshot querySnapshot = await favorites.where('user_id', isEqualTo: userId).get();

    // List to store FavoritePropertyModel instances
    List<FavoritePropertyModel> userFavoritesWithProperties = [];

    // Iterate through the favorite documents
    for (QueryDocumentSnapshot favoriteDoc in querySnapshot.docs) {
      // Extract favorite data
      FavoriteModel favorite = FavoriteModel.fromMap(favoriteDoc.id, favoriteDoc.data() as Map<String, dynamic>);

      // Fetch the associated property using property_id
      DocumentSnapshot propertySnapshot = await properties.doc(favorite.propertyId).get();
      
      // Check if the property exists
      if (propertySnapshot.exists) {
        // Convert the property data to PropertyModel instance
        PropertyModel property = PropertyModel.fromMap(propertySnapshot.id, propertySnapshot.data() as Map<String, dynamic>);

        // Create a FavoritePropertyModel instance combining favorite and property data
        FavoritePropertyModel favoriteWithProperty = FavoritePropertyModel(
          favorite: favorite,
          property: property,
        );

        // Add the combined instance to the list
        userFavoritesWithProperties.add(favoriteWithProperty);
      }
    }

    return userFavoritesWithProperties;
  } catch (e) {
    print('Error fetching favorites with properties: $e');
    // Handle the error as needed
    return [];
  }
}
 
 Future<void> deleteFavorite(String favoriteId) async {
  try {
    // Specify the Firestore collection path for favorites
    CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');

    // Delete the favorite document using the provided favoriteId
    await favorites.doc(favoriteId).delete();
        fetchFavoriteProperties();

  } catch (e) {
    print('Error deleting favorite: $e');
    // Handle the error as needed
  }
}
 
 
   @override
  void initState() {
    super.initState();
    fetchFavoriteProperties();
  }

  Future<void> fetchFavoriteProperties() async {
                 User? user =_auth.currentUser;

    final List<FavoritePropertyModel> fetchedFavorites = await getFavoritesWithProperties(user!.uid);
    setState(() {
      favoriteProperties = fetchedFavorites;
      _isfetching=true;
    });
  }
 
 
 
 
 
 
  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
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
                  children: [favoriteProperties.isNotEmpty?
                              ListView.builder(
                                shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                itemCount: favoriteProperties.length,
                                itemBuilder: (BuildContext context,int index) {
                                  final favoriteProperty = favoriteProperties[index];
                                   final property = favoriteProperty.property;
                                   final favorite = favoriteProperty.favorite;
                                  // var item=bookingHistory[index];
                                  print(property.propertyName);
                                          
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
                                          child: Image.network(property.propertyImages[0],fit: BoxFit.fill,)),
                                          Positioned(top: 14,right: 3,left: 210,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.hotel_sharp),
                                                const SizedBox(width: 3,),
                                                Text(property.propertyName,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                              ],
                                            )),
                                            Positioned(top: 55,right: 3,left: 210,
                                            child: Text(' ₹ ${property.price}',style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                                            Positioned(top: 85,right: 3,left: 210,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.location_pin,size: 20,),
                                                Text(property.streetAddress,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                              ],
                                            )),
                                               Positioned(top: 125,right: 3,left: 210,
                                            child: GestureDetector(
                                              onTap: (){
                                                deleteFavorite(favorite.id);
                                              },
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.delete_outline_sharp,size: 20,color: Colors.red,),
                                                  Text("Remove",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red),),
                                                ],
                                              ),
                                            )), 
                                        //      Positioned(top: 110,right: 3,left: 210,
                                        //     child: Column(
                                        //       children: [
                                        //         Row(
                                        //       children: [
                                        //         const Icon(Icons.calendar_month_sharp,size: 20,),
                                        //         Text('',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        //       ],
                                        //     ), const SizedBox(height: 4,),
                                        //     Row(
                                        //       children: [
                                        //         const Icon(Icons.calendar_month_sharp,size: 20,),
                                        //         Text('item.checkoutDate',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                        //       ],
                                        //     )
                                        //       ],
                                        //     )),
                                        //     Positioned(bottom: 15,right: 15,
                                        //       child: GestureDetector(
                                        //         onTap: () {
                                        // // Navigator.push(context, MaterialPageRoute(builder:(context) => UserTicket(propertID: item.propertyId, username: userData!.name, uid: user!.uid, vendorID: item.vendorId,),));
      
                                        //         },
                                        //         child: Icon(Icons.report_problem_sharp,color: Colors.red,)))
                                            
                                      ]),
                                    ),
                                  );
                                
                               })
                               :Column(
         children: [
          SizedBox(height:height/3 ,),
           Center(
             child:  Text("No favorites")
           ),
         ],
       )
       ,
                   
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
      
      /*Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your favorites content here
            const Text(
              'Your Favorite Properties',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // You can display a list of favorite properties here
            // Example:
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beautiful Villa'),
              subtitle: const Text('3 bedrooms, 2 bathrooms'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  // Remove from favorites or add your logic here
                },
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.apartment),
              title: const Text('Luxury Apartment'),
              subtitle: const Text('2 bedrooms, 2 bathrooms'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  // Remove from favorites or add your logic here
                },
              ),
            ),
            const SizedBox(height: 20),
            // Add more favorite properties as needed
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Cozy Cottage'),
              subtitle: const Text('2 bedrooms, 1 bathroom'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  // Remove from favorites or add your logic here
                },
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.apartment),
              title: const Text('Spacious Penthouse'),
              subtitle: const Text('4 bedrooms, 3 bathrooms'),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  // Remove from favorites or add your logic here
                },
              ),
            ),
            // Add more favorite properties as needed
          ],
        ),
      ),*/
    );
  }
}




// Future<List<BookingModel>> getBookingHistory(String userId) async {
//   try {
//     // Specify the Firestore collection path
//     CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

//     // Query the collection for bookings with the specified user ID
//     QuerySnapshot querySnapshot = await bookings.where('user_id', isEqualTo: userId).get();

//     // Convert the query snapshot to a list of BookingModel instances
//     List<BookingModel> userBookings = querySnapshot.docs
//         .map((doc) => BookingModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
//         .toList();
//     showToast("Booking History", Colors.green);

//     return userBookings;
//   } catch (e) {
//         showToast("Booking History", Colors.red);

//     print('Error fetching booking history: $e');
//     // Handle the error as needed
//     return [];
//   }
// }


// Future<void> fetchBookingHistoryData() async {
//             User? user =_auth.currentUser;
// if (user != null) {

//     // Fetch the booking history data and update the state
//     final List<BookingModel> fetchedBookingHistory = await getBookingHistory(user.uid);
//     setState(() {
//       favproperty = fetchedBookingHistory;
//       _isfetching=true;
//     });
// }
//   }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchBookingHistoryData();
//     fetchProfile();
//   }

//    void showToast(String message, var color) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: color,
//       textColor:color!=Colors.black?Colors.black: Colors.white,
//     );
//   }

//   UserModel? userData;
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
// User? user;
// void fetchProfile() async {
//            user = _auth.currentUser;

// if (user != null) {
//       // User is already logged in, retrieve user data
//        userData = await getUserData(user!.uid);
  
//     } 
// }

//  ///////////////////////////////////////////////
 
//  Future<List<FavoriteModel>> getFavorites(String userId) async {
//   try {
//     CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');

//     // Query the collection for favorites with the specified user ID
//     QuerySnapshot querySnapshot = await favorites.where('user_id', isEqualTo: userId).get();

//     // Convert the query snapshot to a list of FavoriteModel instances
//     List<FavoriteModel> userFavorites = querySnapshot.docs
//         .map((doc) => FavoriteModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
//         .toList();

//     return userFavorites;
//   } catch (e) {
//     print('Error fetching favorites: $e');
//     // Handle the error as needed
//     return [];
//   }
// }