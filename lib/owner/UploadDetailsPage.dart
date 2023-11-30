import 'package:flutter/material.dart';

import '../home/PropertyListingPage.dart';

class InputField extends StatelessWidget {
  final String title;
  final bool isSecured;
  final TextEditingController? controller;
  final bool enabled;
  final String? Function(String?)? validator;

  const InputField({
    Key? key,
    required this.title,
    required this.isSecured,
    this.controller,
    this.enabled = true,
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
              obscureText: isSecured,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              controller: controller,
              enabled: enabled,
              validator: validator, // Pass the validator function here
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadDetailsPage extends StatefulWidget {
  const UploadDetailsPage({super.key});

  @override
  _UploadDetailsPageState createState() => _UploadDetailsPageState();
}

class _UploadDetailsPageState extends State<UploadDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to store property and owner details
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerEmailController = TextEditingController();
  TextEditingController ownerPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Upload Property Details'),
            centerTitle: true,
          backgroundColor:  Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  title: 'Owner Name',
                  isSecured: false,
                  controller: ownerNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Owner Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  title: 'Email ID',
                  isSecured: false,
                  controller: ownerEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid Email ID';
                    }
                    // You can add email validation logic here if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  title: 'Phone Number',
                  isSecured: false,
                  controller: ownerPhoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Phone Number';
                    }
                    // You can add phone number validation logic here if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Additional fields for owner details
                InputField(
                  title: 'Location',
                  isSecured: false,
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputField(
                  title: 'Landmark',
                  isSecured: false,
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Landmark nearby!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Perform login logic here

                        // After successful login, navigate to the OwnerPage
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const PropertyListingPage(),
                          ),
                        );
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
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
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
