import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/database_helper.dart';
import 'package:frivillighed_rfam/models/event.dart';
import 'package:frivillighed_rfam/screens/activities_screen.dart';

class EventsScreen extends StatefulWidget {
  static const id = "events";
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {

  @override
  void initState() {
    super.initState();

    printEvents();

  }

  void printEvents() async {
    List<Event> events = await DatabaseHelper().getEvents();

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
      body: TextButton(
        child: const Text('Go to activities screen'),
        onPressed: () {
          Navigator.of(context).pushNamed(ActivitiesScreen.id);
        },
      ),
    );
  }
}
