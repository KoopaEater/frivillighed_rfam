import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/drawers/admin_options_drawer.dart';
import 'package:frivillighed_rfam/drawers/default_options_drawer.dart';
import 'package:frivillighed_rfam/helpers/database_helper.dart';
import 'package:frivillighed_rfam/models/event.dart';
import 'package:frivillighed_rfam/providers/authentication_provider.dart';
import 'package:frivillighed_rfam/providers/main_provider.dart';
import 'package:frivillighed_rfam/screens/activities_screen.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  static const id = "/events";
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Event? chosenEvent;

  final Event dummy = Event(
    id: "0LvtVQ1LaMMTWfMjU3eR",
    name: "Test event",
    date: DateTime(2024, DateTime.june, 28, 12),
  );

  @override
  void initState() {
    super.initState();

    printEvents();
  }

  void printEvents() async {
    List<Event> events = await DatabaseHelper().getEvents();
    chosenEvent = events[0];
    for (Event e in events) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frivillighed RFAM'),
      ),
      endDrawer: Provider.of<AuthenticationProvider>(context).signedIn ? const AdminOptionsDrawer() : const DefaultOptionsDrawer(),
      body: TextButton(
        child: const Text('Go to activities screen'),
        onPressed: () {
          Provider.of<MainProvider>(context, listen: false).chosenEvent = dummy;
          Navigator.of(context).pushNamed(ActivitiesScreen.id);
        },
      ),
    );
  }
}
