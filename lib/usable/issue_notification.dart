import 'package:flutter/material.dart';

class NotificationPopupMenu extends StatefulWidget {
  const NotificationPopupMenu({super.key});

  @override
  State<NotificationPopupMenu> createState() => _NotificationPopupMenuState();
}

class _NotificationPopupMenuState extends State<NotificationPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.notifications,
        color: Colors.black,
      ),
      itemBuilder: (BuildContext context) {
        // Replace this with your list of resolved issues status
        return <PopupMenuEntry>[
          const PopupMenuItem(
            child: Text('Issue 1 Resolved'),
          ),
          const PopupMenuItem(
            child: Text('Issue 2 Resolved'),
          ),
          // Add more items for each resolved issue
        ];
      },
    );
  }
}
