import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/add_activity_button.dart';
import 'package:frivillighed_rfam/buttons/buttons_constants.dart';
import 'package:frivillighed_rfam/buttons/text_icon_button.dart';
import 'package:frivillighed_rfam/buttons/wanna_help_button.dart';
import 'package:frivillighed_rfam/buttons/write_message_button.dart';
import 'package:frivillighed_rfam/dialogs/wanna_help_dialog.dart';
import 'package:frivillighed_rfam/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: Provider.of<AuthenticationProvider>(context).signedIn,
          child: const AddActivityButton(),
        ),
        const WriteMessageButton(),
        const WannaHelpButton(),
      ],
    );
  }
}
