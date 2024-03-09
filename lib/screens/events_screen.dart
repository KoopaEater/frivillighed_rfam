import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/screens/activities_screen.dart';

class EventsScreen extends StatelessWidget {
  static const id = "events";
  const EventsScreen({super.key});

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
