import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'cookie_policy.dart';
import 'privacy_policy.dart';
import 'terms_and_conditions.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'About ',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue.shade900, // Color for "About"
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none, // Remove underline
                            ),
                          ),
                          TextSpan(
                            text: 'AbsoluteStay',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.cyan.shade600, // Color for "AbsoluteStay"
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none, // Remove underline
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    'images/about.json',
                    height: 200,
                    width: 200,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome to AbsoluteStay – Your Home Away from Home',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'At AbsoluteStay, We understand the importance of finding the perfect place to stay, and that\'s why we\'re dedicated to providing you with exceptional accommodations that will make your trip truly memorable.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Our Story',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Founded in 2022, AbsoluteStay has been a trusted name in the Property Management industry for over a decade. Our journey began with a simple mission: to offer travelers a comfortable and convenient alternative to traditional hotels. Over the years, we\'ve grown and evolved, but our commitment to excellence remains unwavering.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Our Commitment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Quality and Comfort: We take pride in offering a diverse range of carefully curated properties, from cozy apartments to luxurious villas. Each property is meticulously selected and maintained to ensure the highest standards of quality and comfort. When you stay with us, you can expect nothing but the best.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Personalized Service: Our dedicated team is here to cater to your every need. Whether it\'s arranging airport transfers, recommending local attractions, or ensuring your accommodations are just the way you like them, we\'re here to make your stay as seamless and enjoyable as possible.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Exceptional Value: We believe that luxury shouldn\'t come with a hefty price tag. That\'s why we strive to provide affordable rates without compromising on quality. Our transparent pricing and flexible booking options make it easy for you to find the perfect stay within your budget.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Local Expertise: Our properties are located in some of the most vibrant and sought-after destinations. With our deep local knowledge, we can offer insider tips and recommendations to help you explore the best of each location.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Our Team',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Behind AbsoluteStay is a passionate and dedicated team of professionals who share a love for travel and a commitment to providing outstanding service. We\'re here to ensure that your stay with us exceeds your expectations in every way.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Join Us on Your Journey',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Whether you\'re traveling for business, leisure, or a special occasion, AbsoluteStay is your trusted partner for exceptional accommodations. We invite you to explore our portfolio of properties and embark on a journey of comfort and discovery with us.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Thank you for choosing AbsoluteStay. We look forward to hosting you and helping you create unforgettable memories wherever your travels may take you.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'If you have any questions or need assistance, please don\'t hesitate to contact us at absolutestay.co.in – we\'re here to make your stay absolute perfection.',
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3.0, // Adjust the word spacing as needed
                  ),
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
