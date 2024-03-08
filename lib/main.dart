import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/screens/activities_screen.dart';
import 'package:frivillighed_rfam/screens/events_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivillighed RFAM',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F7FF),
      ),
      initialRoute: EventsScreen.id,
      routes: {
        EventsScreen.id:          (context) => EventsScreen(),
        ActivitiesScreen.id:      (context) => ActivitiesScreen(),
      },
    );
  }
}