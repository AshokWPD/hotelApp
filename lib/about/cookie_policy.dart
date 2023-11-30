import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class CookiePolicyPage extends StatelessWidget {
  const CookiePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Handle the back action here.
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Cookie Policy for',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'https://absolutestay.co.in/',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Last Updated: 12/09/2023',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  '1. Introduction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to https://absolutestay.co.in/. This website uses cookies. By using our website, you consent to the use of cookies in accordance with this Cookie Policy.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),

                ),
                const SizedBox(height: 20),
                const Text(
                  '2. What Are Cookies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cookies are small text files that are stored on your device when you visit a website. They are widely used to make websites work more efficiently and to provide information to the owners of the site.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '3. How We Use Cookies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'We use cookies for a variety of purposes, including:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Authentication: We use cookies to identify you when you visit our website and as you navigate our website.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Security: We use cookies to help protect your account and personal information.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Analysis: We use cookies to analyze the use and performance of our website.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Preferences: We use cookies to store your preferences in relation to the use of cookies more generally.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '4. Types of Cookies We Use',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Session Cookies: These cookies are temporary and are deleted from your device when you close your web browser.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Persistent Cookies: These cookies remain on your device until they expire or you delete them.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• First-party Cookies: These cookies are set by our website.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Third-party Cookies: These cookies are set by third-party domains.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '5. Your Choices Regarding Cookies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'You can manage your cookies preferences by adjusting the settings on your browser (see your browser Help for how to do this). Note that if you disable cookies, some features of our website may not function properly.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '6. More Information about Cookies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'To learn more about cookies, including how to see what cookies have been set and how to manage and delete them, visit www.allaboutcookies.org.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '7. Changes to This Cookie Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'We may update our Cookie Policy from time to time. We will notify you of any changes by posting the new Cookie Policy on this page.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '8. Contact Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'If you have any questions about this Cookie Policy, please contact us:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• By email: absolutestay.co.in',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  '• By visiting this page on our website: https://absolutestaycorporatelivings.com/contact-us',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '________________________________________',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
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
      ),
    );
  }
}
