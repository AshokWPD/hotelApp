import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../usable/input_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/ticketModel.dart';
import '../usable/issue_notification.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool isSecured;
  final bool enabled;
  final bool showPasswordToggle;
  final TextInputType keyboardType;
  final int? maxLines; // Add maxLines parameter
  final int? maxLength; // Add maxLength parameter
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.title,
    this.controller,
    this.isSecured = false,
    this.enabled = true,
    this.showPasswordToggle = false,
    this.keyboardType = TextInputType.text,
    this.maxLines, // Include maxLines parameter in the constructor
    this.maxLength, // Include maxLength parameter in the constructor
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              controller: controller,
              obscureText: isSecured,
              enabled: enabled,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: isSecured && showPasswordToggle
                    ? IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Implement password visibility toggle here
                  },
                )
                    : null,
              ),
              keyboardType: keyboardType,
              maxLines: maxLines, // Use the specified maxLines
              maxLength: maxLength, // Use the specified maxLength
              validator: validator, // Use the specified validator
            ),
          ),
        ],
      ),
    );
  }
}

class UserTicket extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
final String propertID;
final String username;
final String uid;
final String vendorID;



  UserTicket({super.key, required this.propertID, required this.username, required this.uid, required this.vendorID});

Future<void> createTicket(TicketModel ticket) async {
  try {
    await FirebaseFirestore.instance.collection('tickets').add(ticket.toMap());
    print('Ticket created successfully!');
  } catch (e) {
    print('Error creating ticket: $e');
  }
}

TextEditingController _message=TextEditingController();
TextEditingController _description=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raise Your Ticket'),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: const [
          NotificationPopupMenu(),
        ],
      ),
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // InputField(
                //   title: 'Your Name',
                //   isSecured: false,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your full name';
                //     }
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20.0,),
                // InputField(
                //   title: 'Email',
                //   isSecured: false,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your email';
                //     }
                //     // Add email validation logic if needed
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20.0,),
                // InputField(
                //   title: 'Phone Number',
                //   isSecured: false,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your phone number';
                //     }
                //     // Add phone number validation logic if needed
                //     return null;
                //   },
                // ),
                const SizedBox(height: 20.0,),
                InputField(
                  controller: _message,
                  title: 'Message',
                  isSecured: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0,),// Add a TextField for Description
                CustomTextField(
                  controller: _description,
                  title: 'Description(Optional)',
                  maxLines: 5, // Allow multiple lines of text
                  maxLength: 200,
                  validator: (value) {
                    // Add validation logic for the description
                    return null;
                  },// Limit the text to 200 characters
                ),
                const SizedBox(height: 30.0,),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState!.validate()) {
            final TicketModel ticketmodel=TicketModel(
              ticketId: '', 
              propertyId: propertID, 
              userName: username, 
              userId: uid, 
              message: _message.text, 
              description: _description.text, 
              status: "Ticket", 
              replyMessage: "", 
              isAdmin: false, vendorId: vendorID);
              await createTicket(ticketmodel);
                      _UserTicket();
                      // Handle form submission
                      // You can access the form fields using _formKey.currentState
                      // Send the form data as needed
                    }
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
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _UserTicket() async {
    Fluttertoast.showToast(
      msg: 'Your issue ticket has been raised successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      webShowClose: true,
      webBgColor: "linear-gradient(to right, #ffaa00, #ff7700)",
    );
  }
}
