import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../model/bookingModel.dart';
import '../model/usermodel.dart';
import 'container_button.dart';


class PropertySpecificationPopUp extends StatefulWidget {
  final String vendorid;
  final double priceamount;
  final String subvendor_id;
  final String propertyId;
  final String propertyImage;
  final String location;
  final String PropertyName;


  const PropertySpecificationPopUp({super.key, required this.vendorid, required this.priceamount, required this.subvendor_id, required this.propertyId, required this.propertyImage, required this.location, required this.PropertyName});


  @override
  State<PropertySpecificationPopUp> createState() => _PropertySpecificationPopUpState();
}

class _PropertySpecificationPopUpState extends State<PropertySpecificationPopUp> {
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
           user =await _auth.currentUser;

if (user != null) {
      // User is already logged in, retrieve user data
       userData = await getUserData(user!.uid);
}
}
  
  


Future<void> activateProperty(String propertyId) async {
  try {
    await FirebaseFirestore.instance
        .collection('Property')
        .doc(propertyId)
        .update({'bookStatus': 'Booked',
        'isbookedBy':'${user!.uid}'});
        showToast("Publish Successfully", Colors.green);
  } catch (e) {
            showToast("Failed to Publish", Colors.red);

    print('Error activating property: $e');
    // Handle the error as needed
  }
}






  
  final TextStyle tstyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  final TextStyle tstyle2 = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfile();
  }
  void showToast(String message, var color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor:color==Colors.black?Colors.white: Colors.black,
    );
  }
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  double _dialogHeight = 0.0; // Initial height

  List<String> locations = ['None', 'Bangalore', 'Hyderabad', 'Chennai', 'Mumbai'];
  String selectedLocation = 'None';

  List<String> budgetOptions = ['Any', 'Low', 'Medium', 'High'];
  String selectedBudget = 'Any';

  List<String> preferredOptions = [ '1', '2', '3'];
  String selectedPreferred = '1';

  List<String> genderOptions = ['Any', 'Male', 'Female', 'Other'];
  String selectedGender = 'Any';

  DateTime? checkInDate;
  DateTime? checkOutDate;

  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller, {
        bool isMonth = false,
        bool isYear = false,
      }) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate.subtract(
        isYear ? const Duration(days: 365 * 10) : const Duration(days: 365),
      ),
      lastDate: currentDate.add(
        isYear ? const Duration(days: 365 * 10) : const Duration(days: 365),
      ),
      initialDatePickerMode: isYear ? DatePickerMode.year : DatePickerMode.day,
    );

    if (picked != null) {
      final formattedDate = isYear
          ? DateFormat('yyyy').format(picked)
          : isMonth
          ? DateFormat('MM/yyyy').format(picked)
          : DateFormat('dd/MM/yyyy').format(picked);
      controller.text = formattedDate;
    }
  }


Future<void> uploadBookingData(BookingModel booking) async {
  try {
    // Specify the Firestore collection path and generate a new document ID
    CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
    DocumentReference documentReference = bookings.doc();

    // Convert the BookingModel to a Map
    Map<String, dynamic> bookingData = booking.toMap();

    // Upload the data to Firestore
    await documentReference.set(bookingData);
        showToast("Booking Success", Colors.green);
activateProperty(widget.propertyId);
    print('Booking data uploaded successfully!');
  } catch (e) {
        showToast("Somthing went wrong", Colors.red);

    print('Error uploading booking data: $e');
    // Handle the error as needed
  }
}




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // DropdownButtonFormField<String>(
                                //   value: selectedLocation,
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       selectedLocation = newValue!;
                                //     });
                                //   },
                                //   items: locations.map((String location) {
                                //     return DropdownMenuItem<String>(
                                //       value: location,
                                //       child: Text(location),
                                //     );
                                //   }).toList(),
                                //   decoration: InputDecoration(
                                //     icon: Icon(Icons.location_on, color: customColor),
                                //     labelText: 'Location',
                                //     labelStyle: TextStyle(color: customColor, fontSize: 22),
                                //     focusedBorder: UnderlineInputBorder(
                                //       borderSide: BorderSide(color: customColor),
                                //     ),
                                //   ),
                                // ),
                                DropdownButtonFormField<String>(
                                  value: selectedPreferred,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPreferred = newValue!;
                                    });
                                  },
                                  items: preferredOptions.map((String rating) {
                                    return DropdownMenuItem<String>(
                                      value: rating,
                                      child: Text(rating),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.group, color: customColor),
                                    labelText: 'Sharing Preference',
                                    labelStyle: TextStyle(color: customColor, fontSize: 22),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: customColor),
                                    ),
                                  ),
                                ),
                                // DropdownButtonFormField<String>(
                                //   value: selectedBudget,
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       selectedBudget = newValue!;
                                //     });
                                //   },
                                //   items: budgetOptions.map((String budget) {
                                //     return DropdownMenuItem<String>(
                                //       value: budget,
                                //       child: Text(budget),
                                //     );
                                //   }).toList(),
                                //   decoration: InputDecoration(
                                //     icon: Icon(Icons.monetization_on, color: customColor),
                                //     labelText: 'Budget',
                                //     labelStyle: TextStyle(color: customColor, fontSize: 22),
                                //     focusedBorder: UnderlineInputBorder(
                                //       borderSide: BorderSide(color: customColor),
                                //     ),
                                //   ),
                                // ),
                                DropdownButtonFormField<String>(
                                  value: selectedGender,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue!;
                                    });
                                  },
                                  items: genderOptions.map((String gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person, color: customColor),
                                    labelText: 'Gender',
                                    labelStyle: TextStyle(color: customColor, fontSize: 22),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: customColor),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _selectDate(context, checkInDateController),
                                  child: SizedBox(
                                    child: TextFormField(
                                      onTap: () => _selectDate(context, checkInDateController),
                                      controller: checkInDateController,
                                      // enabled: false,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: 'Check-in Date',
                                        hintText: 'dd/mm/yyyy',
                                        labelStyle: TextStyle(color: customColor),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: customColor),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () => _selectDate(context, checkInDateController),
                                          child: Icon(Icons.calendar_today, color: customColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _selectDate(context, checkOutDateController),
                                  child: TextFormField(
                                  onTap: () => _selectDate(context, checkOutDateController),
                                      readOnly: true,
                                    controller: checkOutDateController,
                                    decoration: InputDecoration(
                                      labelText: 'Check-out Date',
                                      hintText: 'dd/mm/yyyy',
                                      labelStyle: TextStyle(color: customColor),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: customColor),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () => _selectDate(context, checkOutDateController),
                                        child: Icon(Icons.calendar_today, color: customColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    final BookingModel booking =BookingModel(
                                    id: '',
                                    vendorId: widget.vendorid,
                                     userName: userData!.name, 
                                     ticketId: "ticketId", 
                                     memberCount: int.parse(selectedPreferred), 
                                     checkinDate: checkInDateController.text, 
                                     checkoutDate: checkOutDateController.text, 
                                     priceAmount: widget.priceamount, 
                                     isPaid: false, 
                                     subvendorId: '', 
                                     userId: user!.uid, 
                                     propertyId: widget.propertyId, 
                                     status: "booked", 
                                     location: widget.location, 
                                     discount: 0, 
                                     paymentMode: "paymentMode", 
                                     propertyImages: widget.propertyImage, 
                                     bookingStatus: "Booked", gender: selectedGender, PropertyName: widget.PropertyName);
                                                     await uploadBookingData(booking);

                                    await Future.delayed(const Duration(milliseconds: 50), () {
                                      setState(() {
                                        _dialogHeight = 0;
                                      });
                                    });
                                    await Future.delayed(const Duration(milliseconds: 450));
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                        if (states.contains(MaterialState.pressed)) {
                                          return const Color.fromRGBO(33, 37, 41, 1.0);
                                        }
                                        return customColor;
                                      },
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Book Now',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
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
          },
        );
      },
      child: ContainerButton(
        containerWidth: MediaQuery.of(context).size.width / 1.5,
        text: 'Book Now',
        bgColor: customColor,
      ),
    );
  }
}
