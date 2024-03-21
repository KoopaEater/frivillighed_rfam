import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/firebase_options.dart';
import 'package:frivillighed_rfam/providers/main_provider.dart';
import 'package:frivillighed_rfam/screens/activities_screen.dart';
import 'package:frivillighed_rfam/screens/events_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUrlStrategy(PathUrlStrategy());
  runApp(const FrivillighedRFAM());
}

class FrivillighedRFAM extends StatelessWidget {
  const FrivillighedRFAM({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      child: MaterialApp(
        title: 'Frivillighed RFAM',
        theme: ThemeData(
          useMaterial3: false,
          colorSchemeSeed: const Color(0xFF094E94),
        ),
        initialRoute: EventsScreen.id,
        routes: {
          EventsScreen.id: (context) => const EventsScreen(),
          ActivitiesScreen.id: (context) => ActivitiesScreen(),
        },
      ),
    );
  }
}
