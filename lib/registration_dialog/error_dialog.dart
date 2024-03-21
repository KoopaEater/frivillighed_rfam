import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/registration_dialog/dialog_constants.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  const ErrorDialog({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogCornerRadius),
      ),
      title: Text(title),
      content: SizedBox(
        width: errorDialogWidth,
        child: SingleChildScrollView(
          child: Text(message),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
