import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';
import 'package:frivillighed_rfam/dialogs/general_dialog.dart';

class WannaHelpDialog extends StatelessWidget {
  const WannaHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Jeg vil gerne bare hjælpe",
            style: titleTextStyle,
          ),
          Align(
            alignment: Alignment.topRight,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tilbage"),
            ),
          ),
        ],
      ),
    );
  }
}
