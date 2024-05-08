import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/drawers/default_options_drawer_header.dart';

class AdminOptionsDrawer extends StatelessWidget {
  const AdminOptionsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DefaultOptionsDrawerHeader(),
        ],
      ),
    );
  }
}
