import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';

class ActivityAnnotations extends StatelessWidget {

  final List<String> activityStrs;

  const ActivityAnnotations({super.key, required this.activityStrs});

  List<Widget> _getActivities() {
    List<Widget> widgets = [];

    // Add space to the left
    widgets.add(
      const SizedBox(
        width: timeWidth,
      ),
    );

    // Add activity annotations
    for (String activityStr in activityStrs) {
      widgets.add(
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: activityWidth,
            height: activityHeight,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              activityStr,
              style: const TextStyle(color: g1),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _getActivities(),
    );
  }
}
