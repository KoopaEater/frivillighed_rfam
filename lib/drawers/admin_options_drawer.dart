import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/error_dialog.dart';
import 'package:frivillighed_rfam/drawers/default_options_drawer_header.dart';
import 'package:frivillighed_rfam/helpers/authentication_helper.dart';
import 'package:frivillighed_rfam/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class AdminOptionsDrawer extends StatelessWidget {
  const AdminOptionsDrawer({super.key});


  Future<void> _signOut(BuildContext context) async {
    final succes = await AuthenticationHelper().signOut();
    if (succes) {
      Provider.of<AuthenticationProvider>(context, listen: false)
          .currentUser = AuthenticationHelper().currentUser;
    } else {
      showDialog(
        context: context,
        builder: (context) => const ErrorDialog(
          title: "Fejl ved log af",
          message:
          "Der skete en fejl, da vi forsøgte at logge dig af",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DefaultOptionsDrawerHeader(),
          ListTile(
            title: const Text("Log af"),
            leading: const Icon(Icons.logout),
            onTap: () {
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
