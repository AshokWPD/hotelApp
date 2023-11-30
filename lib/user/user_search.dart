import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  void performSearch() {
    // Perform the search operation here using _searchController.text
    // Replace this with your search logic
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromRGBO(33, 84, 115, 1.0);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(255, 241, 241, 241),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: performSearch,
                        child: const Icon(
                          Icons.search,
                          color: customColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      _buildCircleAvatar(
                        iconData: Icons.near_me,
                        text: 'Nearby',
                      ),
                      _buildCircleAvatar(
                        imageAssetPath: 'images/image5.png',
                        text: 'Chennai',
                      ),
                      _buildCircleAvatar(
                        imageAssetPath: 'images/image6.png',
                        text: 'Hyderabad',
                      ),
                      _buildCircleAvatar(
                        imageAssetPath: 'images/image7.png',
                        text: 'Mumbai',
                      ),
                      _buildCircleAvatar(
                        imageAssetPath: 'images/image8.png',
                        text: 'Bangalore',
                      ),
                      // Add more avatars as needed
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add the action for the elevated button here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search,
                    size: 36.0,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
                Lottie.asset(
                  'images/search.json', // Replace with your Lottie animation file path
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleAvatar({
    IconData? iconData,
    String? imageAssetPath,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade200,
            child: iconData != null
                ? Icon(
              iconData,
              color: customColor,
              size: 36.0,
            )
                : ClipOval(
              child: Image.asset(
                imageAssetPath!,
                width: 72.0,
                height: 72.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
