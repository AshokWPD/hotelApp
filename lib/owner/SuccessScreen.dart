import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/success.json', // Replace with your Lottie animation file path
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Success!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Property  was added successfully.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen or perform other actions
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states
                        .contains(MaterialState.pressed)) {
                      return const Color.fromRGBO(
                          33, 37, 41, 1.0);
                    }
                    return const Color.fromRGBO(33, 84, 115, 1.0);
                  },
                ),
              ),
              child: const Text('OK',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
