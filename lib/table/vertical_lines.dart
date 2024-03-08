import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';

class VerticalLines extends StatelessWidget {
  final int lines;

  const VerticalLines({super.key, required this.lines});

  List<Widget> _getLines() {
    List<Widget> widgets = [];

    // Add space at top
    widgets.add(
      Container(
        width: timeWidth,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: g1,
              width: lineThickness,
            ),
          ),
        ),
      ),
    );

    // Add lines
    for (int i = 0; i < lines; i++) {
      widgets.add(
        Container(
          width: activityWidth,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: g1,
                width: lineThickness,
              ),
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
      children: _getLines(),
    );
  }
}
