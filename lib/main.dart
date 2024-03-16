import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/firebase_options.dart';
import 'package:frivillighed_rfam/screens/activities_screen.dart';
import 'package:frivillighed_rfam/screens/events_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FrivillighedRFAM());
}

class FrivillighedRFAM extends StatelessWidget {
  const FrivillighedRFAM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivillighed RFAM',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FF),
      ),
      initialRoute: EventsScreen.id,
      routes: {
        EventsScreen.id: (context) => const EventsScreen(),
        ActivitiesScreen.id: (context) => ActivitiesScreen(),
      },
    );
  }
}
