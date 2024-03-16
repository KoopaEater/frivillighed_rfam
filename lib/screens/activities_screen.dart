import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/models/database_helper.dart';
import 'package:frivillighed_rfam/models/event.dart';
import 'package:frivillighed_rfam/models/volunteer.dart';
import 'package:frivillighed_rfam/models/task.dart';
import 'package:frivillighed_rfam/table/activity_table.dart';

class ActivitiesScreen extends StatefulWidget {
  static const id = "activities";
  final Event event;

  ActivitiesScreen({super.key, required this.event});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final hScrollCtr = ScrollController();
  final vScrollCtr = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  final Set<Activity> activities = {
    Activity(
      category: "Løb",
      title: "60 m D19",
      startTime: DateTime.parse("2024-03-10 11:30"),
      endTime: DateTime.parse("2024-03-10 12:55"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [
            Volunteer(name: "Max Kørner Andersen", phone: "30870746"),
          ],
        ),
        "Hækkeflytter": Task(
          volunteers: [
            Volunteer(name: "Jonathan Sass Møller", phone: "34567234"),
            Volunteer(name: "Kristine Skifter Bitsch", phone: "39657306"),
          ],
        ),
      },
    ),
    Activity(
      category: "Løb",
      title: "60 m hæk D22",
      startTime: DateTime.parse("2024-03-10 12:55"),
      endTime: DateTime.parse("2024-03-10 13:10"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [],
        ),
      },
    ),
    Activity(
      category: "Kuglestød",
      title: "D15",
      startTime: DateTime.parse("2024-03-10 10:00"),
      endTime: DateTime.parse("2024-03-10 11:15"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [
            Volunteer(name: "Dorte", phone: "29705563"),
          ],
        ),
        "Opmåler": Task(volunteers: []),
        "Tilbagekaster": Task(volunteers: []),
      },
    ),
    Activity(
      category: "Kuglestød",
      title: "D17",
      startTime: DateTime.parse("2024-03-10 11:30"),
      endTime: DateTime.parse("2024-03-10 12:55"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [
            Volunteer(name: "Dorte", phone: "29705563"),
          ],
        ),
        "Opmåler": Task(
          volunteers: [],
        ),
        "Tilbagekaster": Task(
          volunteers: [],
        ),
      },
    ),
    Activity(
      category: "Højdespring",
      title: "D15",
      startTime: DateTime.parse("2024-03-10 13:30"),
      endTime: DateTime.parse("2024-03-10 14:30"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [
            Volunteer(name: "Dorte", phone: "29705563"),
          ],
        ),
        "Opmåler": Task(
          volunteers: [],
        ),
        "Tilbagekaster": Task(
          volunteers: [],
        ),
      },
    ),
    Activity(
      category: "Stangspring",
      title: "D19 + D22",
      startTime: DateTime.parse("2024-03-10 10:00"),
      endTime: DateTime.parse("2024-03-10 14:00"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [
            Volunteer(name: "Rene Kvist", phone: "97255677"),
          ],
        ),
        "Højdemåler": Task(
          volunteers: [],
        ),
      },
    ),
    Activity(
      category: "Bod",
      title: "Bod",
      startTime: DateTime.parse("2024-03-10 09:00"),
      endTime: DateTime.parse("2024-03-10 15:00"),
      tasks: {
        "Hoved ansvarlig(e)": Task(
          editable: false,
          volunteers: [
            Volunteer(name: "Belinda", phone: "62958361"),
          ],
        ),
      },
    ),
  };

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
