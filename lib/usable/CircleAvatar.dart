import 'package:flutter/material.dart';

class CircleAvatarScrollScreen extends StatelessWidget {
  const CircleAvatarScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle Avatar Scroll'),
      ),
      body: const Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CircleAvatarWithIconAndText(
                icon: Icons.near_me,
                text: 'Nearby',
              ),
              CircleAvatarWithImageAndText(
                imageUrl: 'images/image5.png',
                text: 'User 1',
              ),
              CircleAvatarWithImageAndText(
                imageUrl: 'images/image5.png',
                text: 'User 2',
              ),
              CircleAvatarWithImageAndText(
                imageUrl: 'images/image7.png',
                text: 'User 3',
              ),
              CircleAvatarWithImageAndText(
                imageUrl: 'images/image8.png',
                text: 'User 4',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWithIconAndText extends StatelessWidget {
  final IconData icon;
  final String text;

  const CircleAvatarWithIconAndText({super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue, // Adjust the size as needed
            child: Icon(
              icon,
              size: 40, // Adjust the icon size as needed
              color: Colors.white,
            ), // Adjust the background color as needed
          ),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}

class CircleAvatarWithImageAndText extends StatelessWidget {
  final String imageUrl;
  final String text;

  const CircleAvatarWithImageAndText({super.key,
    required this.imageUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40, // Adjust the size as needed
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}
