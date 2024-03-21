import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/helpers/activity_helper.dart';
import 'package:frivillighed_rfam/table/activity_annotations.dart';
import 'package:frivillighed_rfam/table/activity_boxes.dart';
import 'package:frivillighed_rfam/table/horizontal_lines.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';
import 'package:frivillighed_rfam/table/time_annotations.dart';
import 'package:frivillighed_rfam/table/vertical_lines.dart';

class ActivityTable extends StatefulWidget {
  final List<Activity> activities;

  const ActivityTable({super.key, required this.activities});

  @override
  State<ActivityTable> createState() => _ActivityTableState();
}

class _ActivityTableState extends State<ActivityTable> {
  late final List<String> timeLabels;
  late final List<String> activityLabels;

  @override
  void initState() {
    super.initState();

    timeLabels = ActivityHelper().getTimeLabels(widget.activities);
    activityLabels = ActivityHelper().getActivityLabels(widget.activities);

  }

  double _getWidth() {
    return (timeWidth) +
        (activityWidth * activityLabels.length) +
        (2 * tablePadding);
  }

  double _getHeight() {
    return (activityHeight * 2) +
        (timeHeight * timeLabels.length) +
        (2 * tablePadding);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getWidth(),
      height: _getHeight(),
      child: Padding(
        padding: const EdgeInsets.all(tablePadding),
        child: Stack(
          children: [
            HorizontalLines(lines: timeLabels.length),
            TimeAnnotations(timeStrs: timeLabels),
            VerticalLines(lines: activityLabels.length),
            ActivityAnnotations(activityStrs: activityLabels),
            ActivityBoxes(activities: widget.activities),
          ],
        ),
      ),
    );
  }
}
