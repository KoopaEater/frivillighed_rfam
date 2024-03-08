import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';

class ActivityBoxes extends StatefulWidget {
  final Map<String, Set<Activity>> activities;

  const ActivityBoxes({super.key, required this.activities});

  @override
  State<ActivityBoxes> createState() => _ActivityBoxesState();
}

class _ActivityBoxesState extends State<ActivityBoxes> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
