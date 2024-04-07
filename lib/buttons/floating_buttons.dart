import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/buttons_constants.dart';
import 'package:frivillighed_rfam/buttons/text_icon_button.dart';
import 'package:frivillighed_rfam/dialogs/wanna_help_dialog.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextIconButton(
          text: "Skriv til arrangøren",
          icon: Icons.message,
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {},
        ),
        const SizedBox(
          height: buttonSpacing,
        ),
        TextIconButton(
          text: "Jeg vil bare gerne hjælpe",
          icon: Icons.front_hand,
          color: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const WannaHelpDialog(),
            );
          },
        ),
      ],
    );
  }
}
