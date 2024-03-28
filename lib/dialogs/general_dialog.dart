import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';

class GeneralDialog extends StatelessWidget {
  final Widget body;

  const GeneralDialog({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: dialogShape,
      child: Container(
        padding: const EdgeInsets.all(dialogPadding),
        width: min(MediaQuery.of(context).size.width, dialogWidth),
        child: body,
      ),
    );
  }
}
