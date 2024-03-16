import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/models/activity_helper.dart';
import 'package:frivillighed_rfam/table/activity_box.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';

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

  List<Widget> buildColumns(Map<String, Set<Activity>> activityMap) {
    DateTime minTime = ActivityHelper().getMinTimeFromMap(activityMap);
    List<Widget> widgets = [];

    widgets.add(
      const SizedBox(
        width: timeWidth,
      ),
    );

    for (Set<Activity> activities in activityMap.values) {
      widgets.add(
        SizedBox(
          width: activityWidth,
          child: Column(
            children: buildColumn(activities, minTime),
          ),
        ),
      );
    }

    return widgets;
  }

  List<Widget> buildColumn(Set<Activity> colActivities, DateTime minTime) {
    List<Widget> widgets = [];

    widgets.add(
      const SizedBox(
        height: activityHeight,
      ),
    );

    List<Activity> sortedActivities = colActivities.toList();
    sortedActivities.sort((a, b) => a.startTime.compareTo(b.startTime));

    DateTime lastTime = minTime;

    for (Activity activity in sortedActivities) {
      double beforeHeight = ActivityHelper()
              .decimalBetweenDateTimes(lastTime, activity.startTime) *
          timeHeight;

      if (beforeHeight < 0) {
        throw ActivityException(activity, "overlap detected");
      }

      double activityHeight = ActivityHelper()
              .decimalBetweenDateTimes(activity.startTime, activity.endTime) *
          timeHeight;

      if (activityHeight < 0) {
        throw ActivityException(activity, "spans negative time");
      }

      if (beforeHeight > 0) {
        widgets.add(
          Container(
            height: beforeHeight,
          ),
        );
      }

      if (activityHeight > 0) {
        widgets.add(
          ActivityBox(
            activity: activity,
            height: activityHeight,
          ),
        );
      }

      lastTime = activity.endTime;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildColumns(widget.activities),
    );
  }
}
