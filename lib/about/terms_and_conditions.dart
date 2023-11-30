import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cookie_policy.dart';
import 'privacy_policy.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

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
                  'TERMS AND CONDITIONS',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Last Updated: [Date]',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to https://absolutestay.co.in/ (the "Website"), owned and operated by Absolute Stay . These Terms and Conditions ("Terms") govern your use of our Website. By accessing or using our Website, you agree to comply with and be bound by these Terms. If you do not agree with these Terms, please do not use our Website.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '1. Acceptance of Terms',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  '1.1. By using our Website, you agree to abide by these Terms and any additional terms and policies referenced herein.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '2. Privacy Policy',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  '2.1. Your use of our Website is also governed by our Privacy Policy, which is incorporated into these Terms by reference. Please review our Privacy Policy [link to Privacy Policy] to understand how we collect, use, and protect your personal information.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '3. User Accounts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '3.1. You may be required to create a user account to access certain features of our Website. You are responsible for maintaining the confidentiality of your account credentials and for any activities that occur under your account.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '3.2. You agree to provide accurate and complete information when creating your account and to update your information promptly if it changes.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '4. Use of the Website',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '4.1. You agree to use our Website in accordance with all applicable laws and regulations and in a manner that does not infringe upon the rights of others or violate these Terms.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '4.2. You may not use our Website for any unlawful or unauthorized purposes, including but not limited to distributing harmful software, engaging in fraud, or engaging in any form of harassment or discrimination.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '5. Intellectual Property',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '5.1. All content, text, graphics, logos, images, and software on our Website are the property of Absolute Stay or its licensors and are protected by copyright and other intellectual property laws.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '5.2. You may not use, reproduce, distribute, or display any of our content without our prior written consent.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '6. Third-Party Links and Content',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '6.1. Our Website may contain links to third-party websites or content that is not owned or controlled by us. We are not responsible for the content, privacy practices, or actions of these third parties.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '7. Disclaimer of Warranties',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '7.1. Our Website is provided "as is" and "as available" without any warranties of any kind, either express or implied. We do not warrant that our Website will be error-free, uninterrupted, or free of viruses or other harmful components.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 16),
                const Text(
                  '8. Limitation of Liability',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '8.1. To the fullest extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '9. Indemnification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  '9.1. You agree to indemnify and hold us harmless from any claims, losses, liabilities, costs, and expenses (including attorney\'s fees) arising out of your use of our Website, violation of these Terms, or infringement of any third-party rights.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '10. Governing Law',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '10.1. These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law principles.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '11. Changes to Terms',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '11.1. We reserve the right to modify, amend, or update these Terms at any time. We will notify you of any material changes by posting the revised Terms on our Website. Your continued use of our Website after the posting of changes constitutes your acceptance of such changes.',
                  style: TextStyle(fontSize: 16, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '12. Contact Us',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, wordSpacing: 3.0,),
                ),
                const SizedBox(height: 20),
                const Text(
                  '12.1. If you have any questions or concerns about these Terms, please contact us at [absolutestay.co.in].',
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
      ),
    );
  }
}
