import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_app/model/Maindata.dart';
import 'package:hotel_app/model/usermodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../about/about.dart';
import '../about/cookie_policy.dart';
import '../about/privacy_policy.dart';
import '../about/terms_and_conditions.dart';
import '../home/homepage.dart';
import '../model/propertyModel.dart';
import '../usable/PropertySelection.dart';
import '../user/user_profile.dart';
import 'MyProperty.dart';
import 'Service.dart';
import 'SubVendor_permission.dart';
import 'TicketDetailsPage.dart';
import 'approved_content.dart';
import 'payment_notification.dart';
import 'tenant_list.dart';
import 'unapproved_content.dart';
import 'vacant_list.dart';
import 'package:http/http.dart'as http;

class UpdateProperty extends StatefulWidget {
  final String propertyId;
  const UpdateProperty({Key? key, required this.propertyId}) : super(key: key);

  @override
  _UpdatePropertyState createState() => _UpdatePropertyState();
}

class _UpdatePropertyState extends State<UpdateProperty> {

  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  final Map<String, IconData> menuIcons = {
    'Profile': Icons.account_circle,
    'Add Sub-Vendor': Icons.person,
    'adminServices': Icons.business,
    'Tenant List': Icons.people,
    'My Property': Icons.apartment,
    'Manage Payment': Icons.payment,
    'Vacant List': Icons.home,
    'Ticket list': Icons.receipt,
    'logout': Icons.exit_to_app,
  };

  void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color!=Colors.black?Colors.black: Colors.white,
    );
  }

  void _launchPhone(String phoneNumber) async {
    final Uri uri = Uri.parse('tel:$phoneNumber');
    if (!await launcher.launchUrl(uri)) {
      await launcher.launchUrl(uri);
    } else {
      debugPrint("Could not launch the phone app");
    }
  }

  void _launchEmail(String email) async {
    final Uri uri = Uri.parse('mailto:$email');
    if (!await launcher.launchUrl(uri)) {
      await launcher.launchUrl(uri);
    } else {
      debugPrint("Could not launch the email app");
    }
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

  void handleDrawerSelection(String value, BuildContext context) {
    switch (value) {
      case 'Tenant List':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TenantListPage(),
          ),
        );
        break;
      case 'Manage Payment':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PaymentNotificationPage(),
          ),
        );
        break;
      case 'Add Sub-Vendor':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SubVendorPermission(),
          ),
        );
        break;
      case 'adminServices':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  AdminServicesPage(),
          ),
        );
        break;
      case 'Owner Profile':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UserProfileScreen(),
          ),
        );
        break;
      case 'My Property':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  const MyPropertyApp(),
          ),
        );
        break;
      case 'Vacant List':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>  const VacantListPage(),
          ),
        );
        break;
      case 'Ticket list':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const VendorTicketListPage(),
          ),
        );
        break;
      case 'logout':
        Navigator.pop(context); // Close the drawer if it's open
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
        );
        // Perform logout action
        break;
      default:
      // Handle other selections if needed
        break;
    }
  }
  


  final List<File> _roomImages = [];
  final List<File> _propertyImages = [];
  int _currentImageIndex = 0;
 List<String> _roomImages_ = [];
   List<String> _propertyImages_ = [];
  List<String> imagePaths = [
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    // Add more image paths here
  ];

Future<PropertyModel?> fetchPropertyData() async {
  try {
    DocumentSnapshot propertySnapshot = await FirebaseFirestore.instance
        .collection('Property')
        .doc(widget.propertyId)
        .get();

    if (propertySnapshot.exists) {
      return PropertyModel.fromMap(propertySnapshot.id, propertySnapshot.data() as Map<String, dynamic>);
    } else {
      return null; // Property not found
    }
  } catch (e) {
    print('Error fetching property data: $e');
    // Handle the error as needed
    return null;
  }
}


PropertyModel? existingProperty;
void getProperty()async{
 existingProperty = await fetchPropertyData();

if (existingProperty != null) {
  setState(() {
    propertyNameController.text=existingProperty!.propertyName;
    addressController.text=existingProperty!.streetAddress;
    landmarkController.text=existingProperty!.landmark;
    pincodeController.text=existingProperty!.pincode;
    descriptionController.text=existingProperty!.description;
    roomPriceController.text=existingProperty!.price;
    _roomImages_=existingProperty!.roomImages;
    _propertyImages_=existingProperty!.propertyImages;

  });
} else {
}

}


  TextEditingController propertyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController roomPriceController = TextEditingController();


void _pickImages(ImageType imageType) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png'], // Specify allowed image file extensions
    allowMultiple: true,
  );

  if (result != null) {
    List<File> selectedImages = result.paths.map((path) => File(path!)).toList();
    setState(() {
      if (imageType == ImageType.room) {
        _roomImages.addAll(selectedImages); // Append selected images to _roomImages
      } else {
        _propertyImages.addAll(selectedImages); // Append selected images to _propertyImages
      }
    });
  }
}

Future<void> updatePropertyData(PropertyModel property) async {
  try {
    await FirebaseFirestore.instance
        .collection('Property')
        .doc(property.id) // Use the property's ID as the document ID
        .update(property.toMap()); // Convert the PropertyModel to a map
  } catch (e) {
    print('Error updating property data: $e');
    // Handle the error as needed
  }
}





Future<String> uploadImageToStorage(File file) async {
  final storage = FirebaseStorage.instance;
  final Reference storageReference = storage.ref().child('Property/${file.path.split('/').last}');
  await storageReference.putFile(file);
  return await storageReference.getDownloadURL();
}

void updatePropertydatas()async{

 final PropertyModel property = PropertyModel(
    propertyName: propertyNameController.text,
    propertyType: existingProperty!.propertyType,
    roomType: existingProperty!.roomType,
    streetAddress:addressController.text ,
    vendorId: existingProperty!.vendorId,
    landmark: landmarkController.text,
    pincode: pincodeController.text,
    description: descriptionController.text,
    price: roomPriceController.text,
    status:existingProperty!.status,
    isbookedBy: existingProperty!.isbookedBy,
    bookStatus: existingProperty!.bookStatus,
    statusVendor: existingProperty!.statusVendor,
    gender: existingProperty!.gender,
    features: existingProperty!.features,
    roomImages: existingProperty!.roomImages,
    propertyImages: existingProperty!.propertyImages,
    latitude: existingProperty!.latitude,
    longitude: existingProperty!.longitude, id: existingProperty!.id, 
  );
  await updatePropertyDataImage(property,_roomImages,_propertyImages);

}

Future<void> updatePropertyDataImage(PropertyModel property, List<File> newRoomImages, List<File> newPropertyImages) async {
  try {
    // Upload new room images and get their URLs
    final List<String> roomImageUrls = [];
    for (final file in newRoomImages) {
      final imageUrl = await uploadImageToStorage(file);
      roomImageUrls.add(imageUrl);
    }

    // Upload new property images and get their URLs
    final List<String> propertyImageUrls = [];
    for (final file in newPropertyImages) {
      final imageUrl = await uploadImageToStorage(file);
      propertyImageUrls.add(imageUrl);
    }

    // Update the PropertyModel with new room and property image URLs
    property.roomImages.addAll(roomImageUrls);
    property.propertyImages.addAll(propertyImageUrls);

    // Update the property data in Firestore
    await FirebaseFirestore.instance
        .collection('Property')
        .doc(property.id)
        .update(property.toMap());
        showToast("Updated Successfully", Colors.green);
  } catch (e) {
    print('Error updating property data: $e');
    // Handle the error as needed
  }
}


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProperty();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Property',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme:const IconThemeData(color: Colors.black)
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: customColor,
                ),
                child: const Center(
                  child: Text(
                    'Welcome Owner ! ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(menuIcons['Profile']),
                title: const Text('Profile'),
                onTap: () {
                  handleDrawerSelection('Owner Profile', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['My Property']),
                title: const Text('My Property'),
                onTap: () {
                  handleDrawerSelection('My Property', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['Add Sub-Vendor']),
                title: const Text('Add Sub-Vendor'),
                onTap: () {
                  _showAnimatedDialog(context, const SubVendorPermission());
                },
              ),
              ListTile(
                leading: Icon(menuIcons['Tenant List']),
                title: const Text('List of the Tenants'),
                onTap: () {
                  handleDrawerSelection('Tenant List', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['Manage Payment']),
                title: const Text('Manage Payment'),
                onTap: () {
                  handleDrawerSelection('Manage Payment', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['Vacant List']),
                title: const Text('Vacant List'),
                onTap: () {
                  handleDrawerSelection('Vacant List', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['Ticket list']),
                title: const Text('Tenant Raised Tickets'),
                onTap: () {
                  handleDrawerSelection('Ticket list', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['adminServices']),
                title: const Text('Services Provided by Admin'),
                onTap: () {
                  handleDrawerSelection('adminServices', context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('+91 7845745809'),
                onTap: () => _launchPhone('+917845745809'),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('helpdesk@absolutestay.co.in'),
                onTap: () => _launchEmail('helpdesk@absolutestay.co.in'),
              ),
              ListTile(
                leading: Icon(menuIcons['logout']),
                title: const Text('Logout'),
                onTap: () {
                  handleDrawerSelection('logout', context);
                },
              ),
              const SizedBox(height: 50.0),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Instagram Icon with URL
                        GestureDetector(
                          onTap: () {
                            launcher.launchUrl(Uri.parse('https://www.instagram.com/absolute_stay_coporate_livings/')); // Open Instagram URL
                          },
                          child: const Icon(
                            FontAwesomeIcons.instagram,
                          ),
                        ),
                        // Facebook Icon with URL
                        GestureDetector(
                          onTap: () {
                            launcher.launchUrl(Uri.parse('https://www.facebook.com/absolutestaycorporate')); // Open Facebook URL
                          },
                          child: const Icon(
                            FontAwesomeIcons.facebook,
                          ),
                        ),
                        // Twitter Icon with URL
                        GestureDetector(
                          onTap: () {
                            launcher.launchUrl(Uri.parse('https://twitter.com/AbsoluteStay')); // Open Twitter URL
                          },
                          child: const Icon(
                            FontAwesomeIcons.twitter,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ListTile(
                      title: const Text('Terms & Conditions'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsAndConditionsPage(),
                          ),
                        );
                      },
                    ),

                    ListTile(
                      title: const Text('Cookie Policy for App'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CookiePolicyPage(),
                          ),
                        );
                      },
                    ),

                    ListTile(
                      title: const Text('Privacy Policy'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _buildInputField(
                    title: 'Property Name',
                    controller: propertyNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const PropertySelection(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputField(
                    title: 'Address',
                    controller: addressController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputField(
                    title: 'Landmark',
                    controller: landmarkController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputField(
                    title: 'Pincode',
                    controller: pincodeController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Which Features Does Your Property Have?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Checkbox options for property features
                      for (int i = 0; i < checkboxNames.length; i++)
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(checkboxNames[i],style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),),
                          value: checkboxValues[i],
                          onChanged: (value) => _onCheckboxChanged(i, value!),
                          activeColor: customColor,
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputField(
                    title: 'Enter Description',
                    controller: descriptionController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Property Images? Max 5 image',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (_propertyImages.isNotEmpty||_propertyImages_.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Row(
                            children: [
                              for (int index = 0;
                              index < _propertyImages_.length;
                              index++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: Image.network(_propertyImages_[index]),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _propertyImages_.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),const SizedBox(width: 3,),
                              Row(
                                children: [
                                  for (int index = 0;
                                  index < _propertyImages.length;
                                  index++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                            ),
                                            child: Image.file(_propertyImages[index]),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _propertyImages.removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(4),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                                             onPressed: () => _pickImages(ImageType.property),          //           onPressed: () async {

                          // onPressed: () async {
                          //   final picker = ImagePicker();
                          //   final pickedImage = await picker.pickImage(
                          //     source: ImageSource.gallery,
                          //   );

                          //   if (pickedImage != null) {
                          //     setState(() {
                          //       _propertyImages.add(File(pickedImage.path));
                          //     });
                          //   }
                          // },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color.fromRGBO(33, 37, 41, 1.0);
                                }
                                return const Color.fromRGBO(33, 84, 115, 1.0);
                              },
                            ),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            "Add More",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                   onPressed: () => _pickImages(ImageType.property),          //           onPressed: () async {
          //  _pickImages(isRoomImage: false);

          //           },
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
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text(
                      "Upload Images",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputField(
                    title: 'Room estimated Price',
                    controller: roomPriceController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Room Images
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Room Images: Max 5 images',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (_roomImages_.isNotEmpty||_roomImages.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Row(
                            children: [
                              for (int index = 0;
                              index < _roomImages_.length;
                              index++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: Image.network(_roomImages_[index]),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _roomImages_.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width:3),
                              Row(
                                children: [
                                  for (int index = 0;
                                  index < _roomImages.length;
                                  index++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                            ),
                                            child: Image.file(_roomImages[index]),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _roomImages.removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(4),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                      onPressed: () => _pickImages(ImageType.room),

                          // onPressed: () async {
                          //   final picker = ImagePicker();
                          //   final pickedImage = await picker.pickImage(
                          //     source: ImageSource.gallery,
                          //   );

                          //   if (pickedImage != null) {
                          //     setState(() {
                          //       _roomImages.add(File(pickedImage.path));
                          //     });
                          //   }
                          // },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color.fromRGBO(33, 37, 41, 1.0);
                                }
                                return const Color.fromRGBO(33, 84, 115, 1.0);
                              },
                            ),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            "Add More",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImages(ImageType.room),
                //     onPressed: () async {
                // _pickImages(isRoomImage: true);
                //     },
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
                    icon: const Icon(Icons.image, color: Colors.white),
                    label: const Text(
                      "Upload Room Images",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(height: 5,),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Preview",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CarouselSlider(
                            items: imagePaths.map((imagePath) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              autoPlay: true, // Enable automatic sliding
                              autoPlayInterval: const Duration(seconds: 2), // Set the interval (2 seconds in this example)
                              autoPlayAnimationDuration: const Duration(milliseconds: 800), // Animation duration
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imagePaths.map((imagePath) {
                            int index = imagePaths.indexOf(imagePath);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == index
                                    ? customColor
                                    : Colors.grey,
                              ),
                            );
                          }).toList(),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹2,800 / Day",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "3 Bedroom Apartment in Salwa",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "You can easily book your according to your budget hotel by our website.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     showToast('Saved Successfully',Colors.black);
                      //   },
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      //           (Set<MaterialState> states) {
                      //         if (states.contains(MaterialState.pressed)) {
                      //           return const Color.fromRGBO(33, 84, 115, 1.0);
                      //         }
                      //         return const Color.fromRGBO(33, 37, 41, 1.0);
                      //       },
                      //     ),
                      //   ),
                      //   child: const Text(
                      //     'Save for later',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                                if(_roomImages.length<2||_propertyImages.length<2){
                            showToast("Add atleast 2 images", Colors.red);

                          }else{
                          updatePropertydatas();}
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const SuccessScreen()),
                          // );
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
                          'Add Property',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Divider(height: 5,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onCheckboxChanged(int index, bool value) {
    setState(() {
      checkboxValues[index] = value;
    });
  }

  Widget _buildInputField({
    required String title,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.transparent, width: 0),
            color: const Color.fromARGB(255, 241, 241, 241),
          ),
          child: TextFormField(
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            controller: controller,
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

  List<bool> checkboxValues = List.generate(6, (_) => false);
  List<String> checkboxNames = [
    'Swimming pool',
    'Furnished',
    'Heater',
    'Parking',
    'Heater',
    'Kitchen',
  ];
}

enum ImageType { room, property }