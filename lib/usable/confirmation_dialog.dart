import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatefulWidget {
  final Function onConfirm;

  const ExitConfirmationDialog({super.key, required this.onConfirm});

  @override
  State<ExitConfirmationDialog> createState() => _ExitConfirmationDialogState();
}

class _ExitConfirmationDialogState extends State<ExitConfirmationDialog> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exit App?'),
      content: const Text('Are you sure you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel',
            style: TextStyle(color: customColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm();
          },
          child: Text('Exit',
            style: TextStyle(color: customColor,
            ),
          ),
        ),
      ],
    );
  }
}
