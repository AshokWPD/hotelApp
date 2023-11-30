import 'package:flutter/material.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({super.key});

  @override
  _ReferPageState createState() => _ReferPageState();
}


class _ReferPageState extends State<ReferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer Your Friend'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height:40),
              // Add your refer page content here
              const Text(
                'Refer a Friend',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Add content about how users can refer their friends
              const Text(
                'Refer your friends and earn rewards!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // Add a button or a section for sharing referral codes or links
              ElevatedButton(
                onPressed: () {
                  // Implement logic for sharing referral code or link
                },
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
                child: const Text(
                  'Share Referral Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Add a section for entering a referral code
              const Text(
                'Enter Referral Code:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // Wrap the TextField with a Container for spacing and decoration
              Container(
                width: 200, // Set the desired width
                height: 40, // Set the desired height
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Customize the border color
                    width: 1.0, // Customize the border width
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Customize the border radius
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter referral code',
                    border: InputBorder.none, // Remove the default border
                  ),
                  // Add logic for handling the entered referral code
                ),
              ),
              const SizedBox(height: 20),
              // Add a button or a section for sharing referral codes or links
              ElevatedButton(
                onPressed: () {
                  // Implement logic for sharing referral code or link
                },
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
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
