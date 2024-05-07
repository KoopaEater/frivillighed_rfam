import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/admin_login_dialog.dart';

class OptionDrawer extends StatelessWidget {
  const OptionDrawer({super.key});

  Widget _getHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: ListTile(
        title: Text("Valgmuligheder"),
        textColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _getHeader(context),
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
