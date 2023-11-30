import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/propertyModel.dart';
import 'PropertyDetailPage.dart';


class PropertyListingPage extends StatefulWidget {


  const PropertyListingPage({super.key});

  @override
  State<PropertyListingPage> createState() => _PropertyListingPageState();
}

class _PropertyListingPageState extends State<PropertyListingPage> {
  String? selectedValue1;
  String? selectedValue2;
  TextEditingController _location =TextEditingController();

  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  List<PropertyModel> properties = [];


@override
  void initState() {
    // TODO: implement initState
    super.initState();
        fetchProperties();

  }

bool isfetching =false;
Future<List<PropertyModel>> getAllProperties() async {
  try {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance
        .collection('Property')
        .where('status', isEqualTo: "Approved")
        .get();

    final List<PropertyModel> properties = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return PropertyModel.fromMap(doc.id, data);
    }).toList();

    return properties;
  } catch (e) {
    print('Error fetching properties: $e');
    throw e; // Handle the error as needed
  }
}










  Future<void> fetchProperties() async {
    // Fetch the properties and update the state
    final List<PropertyModel> fetchedProperties = await getAllProperties();
    setState(() {
      properties = fetchedProperties;
      isfetching=true;
    });
  }


  @override
  Widget build(BuildContext context) {
        final height =MediaQuery.of(context).size.height;

    return 
       Scaffold(
        appBar: AppBar(
          title:  const Text(
            "300+ Places to Stay",style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
                  iconTheme:IconThemeData(color: Colors.black)

        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20.0),
                   color: const Color.fromARGB(255, 241, 241, 241),
                 ),
                 child: TextField(
                   controller: _location,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Location',
                     hintStyle: const TextStyle(
                       color: Colors.grey,
                     ),
                     suffixIcon: GestureDetector(
                       onTap: (){},
                       child:  Icon(
                         Icons.search,
                         color: customColor,
                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 15,),
              
              Stack(
                children: [
                 
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 55,
                      width: 150,
                      child: DropdownButtonFormField<String>(
                        value: selectedValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue1 = newValue;
                          });
                        },
                        items: <String>['Relevance', 'Popularity','Low', 'Medium', 'High']
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(fontSize: 15),),
                          ),
                        )
                            .toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: customColor), // Initial border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: customColor), // Border color when focused
                          ),
                          labelText: 'Sort By',
                          labelStyle: TextStyle(color: customColor),
                          hintText: 'Sort By',
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              !isfetching?
              Column(
         children: [
          SizedBox(height:height/3 ,),
           Center(
             child:  LoadingAnimationWidget.staggeredDotsWave(
            color:customColor,
            size: 50,
      ),
           ),
         ],
       ):
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            ListView.builder(
                          shrinkWrap: true,
                                     physics: const NeverScrollableScrollPhysics(),
                              itemCount: properties.length,
                            itemBuilder: (BuildContext context,int index) {
                              var item=properties[index];
                              return GestureDetector(
                                              onTap: () {
                            // Navigate to the property detail page here
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                              builder: (context) =>  PropertyDetailPage(ProppId: item.id,
                                              ),
                              ),
                            );
                                              },
                                              child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                              SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              item.propertyImages[0],
                              fit: BoxFit.cover,
                            ),
                                              ),
                                              Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.propertyName,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8,),
                              
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.streetAddress,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                      Text(
                                  ' ₹ ${item.price}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Text(item.description),
                              ],
                            ),
                                              ),
                              ],
                            ),
                                              ),
                                            );
                                        
                            }),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              )
                
            
            ],
          ),
        ),
      );
    
  }
}

// class PropertyCard extends StatelessWidget {
//   final String image;
//   final String title;
//   final String price;
//   final String distance;
//   final String description;

//   const PropertyCard({
//     Key? key,
//     required this.image,
//     required this.title,
//     required this.price,
//     required this.distance,
//     required this.description,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to the property detail page here
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => const PropertyDetailPage(
//             ),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 5,
//         margin: const EdgeInsets.only(bottom: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: 200,
//               child: Image.asset(
//                 image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8,),
//                   Text(
//                     price,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   const SizedBox(height: 8,),
//                   Text(
//                     distance,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   const SizedBox(height: 8,),
//                   Text(description),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
 

//  /**  const PropertyCard(
//               image: 'images/image1.png',
//               title: 'Hilton Vienna Park',
//               price: '₹2,800 / Day',
//               distance: '2.5km from central',
//               description:
//               'You can easily book your according to your budget hotel by our website.',
//             ),
//             const SizedBox(height: 25,),
//             const PropertyCard(
//               image: 'images/image1.png',
//               title: 'Hotel XYZ',
//               price: '₹2,500 / Day',
//               distance: '3.0km from central',
//               description:
//               'Enjoy your stay at Hotel XYZ with affordable prices and great amenities.',
//             ),
//             const SizedBox(height: 25,),
//             const PropertyCard(
//               image: 'images/image1.png',
//               title: 'Sunset Resorts',
//               price: '₹3,500 / Day',
//               distance: '1.0km from central',
//               description:
//               'Experience a luxurious stay at Sunset Resorts with stunning views.',
//             ),
//             const SizedBox(height: 25,),
//             const PropertyCard(
//               image: 'images/image1.png',
//               title: 'City Suites',
//               price: '₹2,200 / Day',
//               distance: '2.2km from central',
//               description:
//               'City Suites offers comfortable accommodation for your trip.',
//             ), */

