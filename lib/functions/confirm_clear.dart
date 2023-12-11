import 'package:flutter/material.dart';

void showConfirmationDialog(BuildContext context, Function() function) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to delete all data?'),
        actions: [
          TextButton(
            onPressed: () {
              function();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
