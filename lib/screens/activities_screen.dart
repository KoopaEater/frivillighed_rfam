import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/buttons/floating_buttons.dart';
import 'package:frivillighed_rfam/drawers/admin_options_drawer.dart';
import 'package:frivillighed_rfam/drawers/default_options_drawer.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/helpers/database_helper.dart';
import 'package:frivillighed_rfam/models/event.dart';
import 'package:frivillighed_rfam/providers/authentication_provider.dart';
import 'package:frivillighed_rfam/providers/main_provider.dart';
import 'package:frivillighed_rfam/screens/events_screen.dart';
import 'package:frivillighed_rfam/table/activity_table.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatefulWidget {
  static const id = "/activities";

  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final hScrollCtr = ScrollController();
  final vScrollCtr = ScrollController();

  bool loading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadActivities();
    });
  }

  void loadActivities() async {
    Event? chosenEvent =
        Provider.of<MainProvider>(context, listen: false).chosenEvent;

    if (chosenEvent == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, EventsScreen.id, (route) => false);
    } else {
      setState(() {
        loading = true;
      });

      List<Activity> newActivities =
          await DatabaseHelper().getActivities(chosenEvent.id);
      Provider.of<MainProvider>(context, listen: false).activities =
          newActivities;

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frivillighed RFAM'),
      ),
      endDrawer: Provider.of<AuthenticationProvider>(context).signedIn ? const AdminOptionsDrawer() : const DefaultOptionsDrawer(),
      floatingActionButton: const FloatingButtons(),
      body: SafeArea(
        child: Center(
          child: Scrollbar(
            controller: hScrollCtr,
            thumbVisibility: true,
            child: Scrollbar(
              controller: vScrollCtr,
              child: SingleChildScrollView(
                controller: hScrollCtr,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  controller: vScrollCtr,
                  scrollDirection: Axis.vertical,
                  child: Consumer<MainProvider>(
                    builder: (context, provider, child) {
                      return loading
                          ? const CircularProgressIndicator()
                          : ActivityTable(
                              activities: provider.activities!,
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
