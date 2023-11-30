import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cookie_policy.dart';
import 'terms_and_conditions.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                  'Privacy Policy for ABSOLUTE STAY',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:10),
                const Text(
                  'Property Management Services',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'Effective Date: [12/01/2022]',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  '1. Introduction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'Welcome to Absolute Stay. We are committed to protecting the privacy and security of your personal information. This Privacy Policy explains how we collect, use, and disclose personal information in connection with our property management services. You agree to the practices described in this Privacy Policy by using our services.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '2. Information We Collect',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  'We may collect the following types of personal information:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '2.1 Information You Provide: When you use our property management services, you may provide us with information such as your name, contact information, property details, and financial information.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '2.2 Information We Collect Automatically: We may automatically collect certain information when you use our services, including your IP address, device information, and browsing history.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '2.3 Cookies and Similar Technologies: We may use cookies and similar technologies to collect information about your interactions with our website and services. You can manage your cookie preferences through your browser settings.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '3. How We Use Your Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  'We use your personal information for the following purposes:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '3.1 Service Provision: To provide property management services, including property maintenance, tenant communication, and financial transactions.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '3.2 Communication: To communicate with you regarding your property and our services, including updates, notifications, and inquiries.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '3.3 Marketing: To send you promotional materials, newsletters, and updates about our services, where permitted by law. You can opt out of marketing communications at any time.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '3.4 Legal and Security: To comply with legal obligations, respond to legal requests, and protect the security and integrity of our services.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '4. Disclosure of Your Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'We may share your personal information with the following third parties:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '4.1 Service Providers: We may share your information with third-party service providers who assist us in delivering our property management services.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '4.2 Legal Compliance: We may disclose your information to comply with legal obligations, such as responding to subpoenas or government requests.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '4.3 Business Transfers: In the event of a merger, acquisition, or sale of all or part of our assets, your information may be transferred as part of the transaction.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '5. Data Security',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'We take reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the internet or electronic storage is completely secure.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '6. Your Rights',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'You have the following rights regarding your personal information:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '6.1 Access: You can request access to the personal information we hold about you.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '6.2 Correction: You can request the correction of inaccurate or incomplete personal information.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '6.3 Deletion: You can request the deletion of your personal information, subject to legal and contractual restrictions.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '6.4 Withdrawal of Consent: If we process your personal information based on your consent, you can withdraw your consent at any time.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  '7. Contact Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'If you have any questions or concerns about our Privacy Policy or the way we handle your personal information, please contact us at:',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  'Email: absolutestay.co.in',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height:20),
                const Text(
                  'Phone Number: 7845745809',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height:20),
                const Text(
                  '8. Changes to this Privacy Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:20),
                const Text(
                  'We may update this Privacy Policy to reflect changes in our practices or for other operational, legal, or regulatory reasons. The updated Privacy Policy will be posted on our website with the effective date.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
                const Text(
                  'By using our property management services, you agree to the terms of this Privacy Policy.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height:20),
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
                        padding: const EdgeInsets.only(top:20.0),
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
