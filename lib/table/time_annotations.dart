import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';

class TimeAnnotations extends StatelessWidget {
  final List<String> timeStrs;

  const TimeAnnotations({super.key, required this.timeStrs});

  List<Widget> _getTimes() {
    List<Widget> widgets = [];

    // Add space at top
    widgets.add(
      const SizedBox(
        height: activityHeight,
      ),
    );

    // Add timestamps
    for (String timeStr in timeStrs) {
      widgets.add(
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: timeWidth,
            height: timeHeight,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              timeStr,
              style: const TextStyle(color: g2),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _getTimes(),
    );
  }
}
