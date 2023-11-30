import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../about/cookie_policy.dart';
import '../about/privacy_policy.dart';
import '../about/terms_and_conditions.dart';
import '../about/about.dart';
import '../about/contact.dart';
import '../animatedbox/login_options.dart';
import '../icon/profile_login.dart';
import '../usable/ImageCarousel.dart';
import '../usable/card_area.dart';
import '../icon/search.dart';
import '../usable/confirmation_dialog.dart';
import 'PropertyListingPage.dart';
import 'tab_bar_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

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

  void _showAnimatedDialog(BuildContext context, var val) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: val,
        );
      },
    );
  }

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ExitConfirmationDialog(
        onConfirm: () {
          // Close the app when the user confirms
          SystemNavigator.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define your CardData lists here
    List<CardData> cardDataList1 = [
      CardData(
        imagePath: 'images/image1.png',
        title: "Serviced Apartments",
      ),
      CardData(
        imagePath: 'images/image2.png',
        title: "Pay Guest",
      ),
      CardData(
        imagePath: 'images/image3.png',
        title: "Commercial Space",
      ),
      CardData(
        imagePath: 'images/image4.png',
        title: "Resorts",
      ),
    ];
    List<CardData> cardDataList2 = [
      CardData(
        icon: Icons.school,
        title: "Students",
        content: "We book all kinds of national or international tickets for your destination.",
      ),
      CardData(
        icon: Icons.people,
        title: "Working Professionals",
        content: "You can easily book your budget hotel through our website.",
      ),
      CardData(
        icon: Icons.apartment,
        title: "Managed Apartments",
        content: "We provide you the best plans within a short time to explore more.",
      ),
    ];
    List<CardData> cardDataList3 = [
      CardData(
        imagePath: 'images/image5.png',
        title: "Chennai",
        content: "300+ properties",
      ),
      CardData(
        imagePath: 'images/image5.png',
        title: "Hyderabad",
        content: "300+ properties",
      ),
      CardData(
        imagePath: 'images/image7.png',
        title: "Mumbai",
        content: "300+ properties",
      ),
      CardData(
        imagePath: 'images/image8.png',
        title: "Bangalore",
        content: "300+ properties",
      ),
    ];
    return WillPopScope(
        onWillPop: () async {
      _showExitConfirmationDialog();
      return false; // Prevent the default back button behavior
    },
    child:Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    toolbarHeight: 80.0,
                    backgroundColor: Colors.white,
                    pinned: true,
                    floating: false,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Image.asset(
                          'images/logo.png',
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        background: Container(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, bottom: 10.0, right: 12, left: 12),
                      child: Column(
                        children: [
                          const ImageCarousel(),
                          const SizedBox(height: 40),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.home, color: Colors.tealAccent),
                                  SizedBox(height: 5),
                                  Text(' Residence',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_city, color: Colors.cyan),
                                  SizedBox(height: 5),
                                  Text(' Cities',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.people, color: Colors.deepOrangeAccent),
                                  SizedBox(height: 5),
                                  Text(' Customers',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          CardArea(cardDataList: cardDataList1),
                          const SizedBox(height: 40),
                          RichText(
                            text: TextSpan(
                              text: 'For',
                              style: const TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Everyone',
                                  style: TextStyle(
                                    color: customColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          CardArea(cardDataList: cardDataList2),
                          const SizedBox(height: 40),
                          RichText(
                            text: TextSpan(
                              text: 'Featured',
                              style: const TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Locations',
                                  style: TextStyle(
                                    color: customColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          CardArea(cardDataList: cardDataList3),
                          const Text(
                            'Testimonials',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const CustomSwitch(),
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
                          const SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SearchScreen(),
              const ProfileLoginScreen(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: GNav(
                  gap: 8,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  activeColor: customColor,
                  tabBackgroundColor: Colors.grey.shade300,
                  onTabChange: _onTabTapped, // Sync tab change with page change
                  selectedIndex: _currentIndex, // Set the active index
                  padding: const EdgeInsets.all(16),
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.search, text: 'Search'),
                    GButton(icon: Icons.person, text: 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: customColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Welcome !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Property List'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PropertyListingPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_mail),
                  title: const Text('Contact Us'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ContactPage(),
                      ),
                    );
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      _showAnimatedDialog(context, const LoginOptions());
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
                      'Join',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
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
    ),
    );
  }
}
