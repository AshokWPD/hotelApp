
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_app/sub_vendor/tenentListsub.dart';
import 'package:url_launcher/url_launcher.dart'as launcher;
import '../about/about.dart';
import '../owner/payment_notification.dart';
import '../user/user_profile.dart';
import 'ManageVacancyPage.dart';
import '../about/cookie_policy.dart';
import '../about/privacy_policy.dart';
import '../about/terms_and_conditions.dart';
import '../home/homepage.dart';

class SubVendorHomePage extends StatelessWidget {
  SubVendorHomePage({super.key});
  final Map<String, IconData> menuIcons = {
    'Profile': Icons.account_circle,
    'List of the Tenants': Icons.business,
    'Vacant List': Icons.home,
    'Manage Payment': Icons.payment,
    //'Subscription Plans': Icons.payment,
    'Owner Profile': Icons.perm_identity,
    'logout': Icons.exit_to_app,
  };

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


  void handleDrawerSelection(String value, BuildContext context) {
    switch (value) {
      case 'List of the Tenants':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TenantListPageSub(),
          ),
        );
        break;
      case 'Vacant List':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VacantListPage(),
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
      /*case 'Subscription Plans':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SubscriptionPlansPage(),
          ),
        );
        break;*/
      case 'Owner Profile':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UserProfileScreen(),
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

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                    'Welcome Sub-Vendor ! ',
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
                leading: Icon(menuIcons['List of the Tenants']),
                title: const Text('List of the Tenants'),
                onTap: () {
                  handleDrawerSelection('List of the Tenants', context);
                },
              ),
              ListTile(
                leading: Icon(menuIcons['Vacant List']),
                title: const Text('Vacant List'),
                onTap: () {
                  handleDrawerSelection('Vacant List', context);
                },
              ),
              /*ListTile(
                leading: Icon(menuIcons['Subscription Plans']),
                title: const Text('Explore Subscription Plans'),
                onTap: () {
                  handleDrawerSelection('Subscription Plans', context);
                },
              ),*/
              ListTile(
                leading: Icon(menuIcons['Manage Payment']),
                title: const Text('Manage Payment'),
                onTap: () {
                  handleDrawerSelection('Manage Payment', context);
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
                            launcher.launchUrl(Uri.parse(
                                'https://www.instagram.com/absolute_stay_coporate_livings/')); // Open Instagram URL
                          },
                          child: const Icon(
                            FontAwesomeIcons.instagram,
                          ),
                        ),
                        // Facebook Icon with URL
                        GestureDetector(
                          onTap: () {
                            launcher.launchUrl(Uri.parse(
                                'https://www.facebook.com/absolutestaycorporate')); // Open Facebook URL
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 5.0,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Property Overview',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Property Name: Your Property'),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Location: Your Location'),
                      ),
                      ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Total Earnings: \$10,000'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5.0,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('New Booking: John Doe booked your property.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('Payment Received: \$500 received for booking.'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
