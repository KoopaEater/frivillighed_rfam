import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/buttons_constants.dart';
import 'package:frivillighed_rfam/buttons/text_icon_button.dart';
import 'package:frivillighed_rfam/dialogs/add_activity_dialog.dart';

class AddActivityButton extends StatelessWidget {
  const AddActivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextIconButton(
      text: "Tilføj ny aktivitet",
      color: acGreenO,
      icon: Icons.add,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AddActivityDialog(),
        );
      },
    );
  }
}
