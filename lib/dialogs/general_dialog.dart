import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';

class GeneralDialog extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget actions;

  const GeneralDialog({
    super.key,
    required this.title,
    required this.body,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      shape: dialogShape,
      child: Container(
        padding: const EdgeInsets.all(dialogPadding),
        width: min(MediaQuery.of(context).size.width, dialogWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title,
            const SizedBox(
              height: dialogSmallSpacing,
            ),
            Flexible(
              child: body,
            ),
            const SizedBox(
              height: dialogSmallSpacing,
            ),
            Align(
              alignment: Alignment.topRight,
              child: actions,
            ),
          ],
        ),
      ),
    );
  }
}
