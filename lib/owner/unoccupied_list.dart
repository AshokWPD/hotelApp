import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/propertyModel.dart';

class UnoccupiedList extends StatefulWidget {
  const UnoccupiedList({super.key});

  @override
  State<UnoccupiedList> createState() => _UnoccupiedListState();
}

Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

class _UnoccupiedListState extends State<UnoccupiedList> {


    @override
  void initState() {
    super.initState();
    loadUserProperties("free");
  }
// PropertyModel? _property; 
bool _isfetching=false;
List<PropertyModel>_fetchedProperty=[];
// List<PropertyModel> userProperties=[];
 void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color!=Colors.black?Colors.black: Colors.white,
    );
  }


Future<List<PropertyModel>> getPropertiesByStatusAndUser(String userUid, String status) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Property')
        .where('vendorId', isEqualTo: userUid)
        .where('bookStatus', isEqualTo: status)
        .where('status', isEqualTo: "Approved")
        .get();

   List<PropertyModel> userProperties = querySnapshot.docs
    .map((doc) => PropertyModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
    .toList();
setState(() {
  _isfetching=true;

});
    return userProperties;
  } catch (e) {
    print('Error retrieving user properties: $e');
    return [];
  }
}



Future<void> activateProperty(String propertyId) async {
  try {
    await FirebaseFirestore.instance
        .collection('Property')
        .doc(propertyId)
        .update({'bookStatus': 'Booked'});
        showToast("Publish Successfully", Colors.green);
  } catch (e) {
            showToast("Failed to Publish", Colors.red);

    print('Error activating property: $e');
    // Handle the error as needed
  }
}


Future<void> loadUserProperties(String status) async {
  String userUid = FirebaseAuth.instance.currentUser!.uid;

   _fetchedProperty = await getPropertiesByStatusAndUser(userUid, status);


}

  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
   return _isfetching? Column(
         children: [
           SingleChildScrollView(
             child: Container(
               padding: const EdgeInsets.all(16.0),
               child:  Flex(
                direction: Axis.vertical,
                 children: [
                             ListView.builder(
                               shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                               itemCount: _fetchedProperty.length,
                               itemBuilder: (BuildContext context,int index) {
                                 var item=_fetchedProperty[index];
                                 print(item.roomImages[0]);
                                          
                                 return SizedBox(
                                   child: Card(
                                                         elevation: 5,
                                                         margin: const EdgeInsets.only(bottom: 16.0),
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             Stack(
                                                               alignment: Alignment.bottomLeft,
                                                               children: [
                                                     SizedBox(
                                                     width: double.infinity,
                                                     height: 200,
                                                  
                                                     child: Stack(fit: StackFit.passthrough,
                                                      children: [ Center(
                                                         child:  LoadingAnimationWidget.staggeredDotsWave(
                                                        color:customColor,
                                                        size: 30,
                                                  ),
                                                       ),Image.network(item.roomImages[0].toString(),fit: BoxFit.fill,)])
                                                     ),
                                                     Container(
                                                     padding: const EdgeInsets.all(8.0),
                                                     color:  Colors.blue,
                                                     child: const Text(
                                                        "Unoccupied",
                                                       style: TextStyle(
                                                         color: Colors.white,
                                                         fontWeight: FontWeight.bold,
                                                       ),
                                                     ),
                                                     ),
                                                     Container(
                                                     alignment: Alignment.bottomRight,
                                                     child: Container(
                                                       decoration: BoxDecoration(
                                                         color: Colors.grey.shade100, // Replace with your desired background color
                                                     // Optional: Add rounded corners
                                                       ),
                                                       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                       child: const Row(
                                                         mainAxisSize: MainAxisSize.min,
                                                         children: [
                                                      Icon(Icons.star, color: Colors.orange),
                                                      Text(
                                                        // starRating.toStringAsFixed(1),
                                                        "starRating",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                         ],
                                                       ),
                                                     ),
                                                     ),
                                                               ],
                                                             ),
                                                             Padding(
                                                               padding: const EdgeInsets.all(16.0),
                                                               child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                     Text(
                                                       item.propertyName.toString(),
                                                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                     ),
                                                     const SizedBox(height: 8),
                                                     Row(
                                                       children: [
                                                     Icon(Icons.location_on,
                                                      color: customColor,
                                                         ),
                                                         const SizedBox(width: 5),
                                                         Text(
                                                      item.streetAddress.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                         ),
                                                         const SizedBox(width: 20),
                                                     Icon(Icons.home,
                                                      color: customColor,
                                                         ),
                                                         const SizedBox(width: 5),
                                                         Text(
                                                      item.propertyType.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                         ),
                                                       ],
                                                     ),
                                                     const SizedBox(height: 16),
                                                    
                                                     Center(
                                                       child: ElevatedButton(
                                                        onPressed: ()async{
                                                          await activateProperty(item.id);
                                                        loadUserProperties("free");
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
                                                        child: const Text( "Occupied", style: TextStyle(color: Colors.white)),
                                                       ),
                                                     ),
                                                     ],
                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                 );
                                        
                               
                              }),
                  
                             const SizedBox(height: 25.0),
                           ],
               ),
             ),
           ),
         ],
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
       );
    
  }
}

// class PropertyCardData {
//   final String image;
//   final String roomNumber;
//   final String price;
//   final String type;
//   final String location;
//   bool isPublished;
//   final double starRating;

//   PropertyCardData({
//     required this.image,
//     required this.roomNumber,
//     required this.price,
//     required this.type,
//     required this.location,
//     required this.isPublished,
//     required this.starRating,
//   });
// }

// class PropertyCard extends StatelessWidget {
//   final String image;
//   final String roomNumber;
//   final String price;
//   final String type;
//   final String location;
//   final bool isPublished;
//   final double starRating;
//   final VoidCallback onPressed;

//   const PropertyCard({
//     Key? key,
//     required this.image,
//     required this.roomNumber,
//     required this.price,
//     required this.type,
//     required this.location,
//     required this.isPublished,
//     required this.starRating,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             alignment: Alignment.bottomLeft,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 200,
//                 child: Image.asset(
//                   image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8.0),
//                 color: isPublished ? Colors.red : Colors.red,
//                 child: Text(
//                   isPublished ? "Unoccupied" : "Unoccupied",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.bottomRight,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.star, color: Colors.orange),
//                       Text(
//                         starRating.toStringAsFixed(1),
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   roomNumber,
//                   style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: customColor,
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       location,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Icon(
//                       Icons.home,
//                       color: customColor,
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       type,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: onPressed,
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                               (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.pressed)) {
//                               return const Color.fromRGBO(33, 37, 41, 1.0);
//                             }
//                             return const Color.fromRGBO(33, 84, 115, 1.0);
//                           },
//                         ),
//                       ),
//                       child: const Text(
//                         'Available Now',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





////////////////////////
///
///  // List<PropertyCardData> propertyData = [
  //   PropertyCardData(
  //     image: 'images/image1.png',
  //     roomNumber: '1 (2BHK)',
  //     price: '₹2,800 / Day',
  //     type: 'Apartment',
  //     location: 'Chennai',
  //     isPublished: true,
  //     starRating: 4.5,
  //   ),
  //   PropertyCardData(
  //     image: 'images/image2.png',
  //     roomNumber: '1 (2BHK)',
  //     price: '₹2,500 / Day',
  //     type: 'Apartment',
  //     location: 'Chennai',
  //     isPublished: false,
  //     starRating: 3.8,
  //   ),
  //   PropertyCardData(
  //     image: 'images/image3.png',
  //     roomNumber: '3 (2 Sharing)',
  //     price: '₹3,500 / Day',
  //     type: 'PG',
  //     location: 'Chennai',
  //     isPublished: true,
  //     starRating: 4.2,
  //   ),
  //   PropertyCardData(
  //     image: 'images/image4.png',
  //     roomNumber: '3 (2 Sharing)',
  //     price: '₹2,200 / Day',
  //     type: 'PG',
  //     location: 'Chennai',
  //     isPublished: true,
  //     starRating: 4.0,
  //   ),
  // ];

  // void togglePublishStatus(int index) {
  //   setState(() {
  //     propertyData[index].isPublished = !propertyData[index].isPublished;
  //   });
  // }