
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/table/activity_table.dart';

class ActivitiesScreen extends StatelessWidget {
  static const id = "activities";

  final hScrollCtr = ScrollController();
  final vScrollCtr = ScrollController();

  final Set<Activity> activities = {
    Activity(
      category: "Kuglestød",
      title: "D15",
      startTime: DateTime.parse("2024-03-10 10:00"),
      endTime: DateTime.parse("2024-03-10 11:15"),
    ),
    Activity(
      category: "Kuglestød",
      title: "D17",
      startTime: DateTime.parse("2024-03-10 11:30"),
      endTime: DateTime.parse("2024-03-10 12:55"),
    ),
    Activity(
      category: "Bod",
      title: "Bod",
      startTime: DateTime.parse("2024-03-10 09:00"),
      endTime: DateTime.parse("2024-03-10 15:00"),
    ),
    Activity(
      category: "Løb",
      title: "60 m D19",
      startTime: DateTime.parse("2024-03-10 11:30"),
      endTime: DateTime.parse("2024-03-10 12:55"),
    ),
    Activity(
      category: "Løb",
      title: "60 m hæk D22",
      startTime: DateTime.parse("2024-03-10 12:55"),
      endTime: DateTime.parse("2024-03-10 13:10"),
    ),
  };

  ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frivillighed RFAM'),
      ),
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
                  child: ActivityTable(
                    activities: activities,
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
