import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/admin_login_dialog.dart';
import 'package:frivillighed_rfam/drawers/default_options_drawer_header.dart';

class DefaultOptionsDrawer extends StatelessWidget {
  const DefaultOptionsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DefaultOptionsDrawerHeader(),
          ListTile(
            title: Text("Admin Login"),
            leading: Icon(Icons.admin_panel_settings),
            onTap: () async {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AdminLoginDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
