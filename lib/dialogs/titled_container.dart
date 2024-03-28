import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';

class TitledContainer extends StatelessWidget {
  final String titleText;
  final Widget child;
  final Alignment alignment;

  const TitledContainer({
    super.key,
    required this.titleText,
    required this.child,
    this.alignment = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: dialogBoxTopPadding),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: titleText,
          labelStyle: const TextStyle(color: g2),
          enabledBorder: dialogBoxBorder,
        ),
        child: Align(
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
