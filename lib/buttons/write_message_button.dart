import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/text_icon_button.dart';

class WriteMessageButton extends StatelessWidget {
  const WriteMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextIconButton(
      text: "Skriv til arrangøren",
      icon: Icons.message,
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {},
    );
  }
}
