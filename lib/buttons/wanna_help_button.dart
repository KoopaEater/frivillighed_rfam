import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/text_icon_button.dart';
import 'package:frivillighed_rfam/dialogs/wanna_help_dialog.dart';

class WannaHelpButton extends StatelessWidget {
  const WannaHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextIconButton(
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
    );
  }
}
