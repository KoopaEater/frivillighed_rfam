import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';

class HorizontalLines extends StatelessWidget {
  final int lines;

  const HorizontalLines({super.key, required this.lines});

  List<Widget> _getLines() {
    List<Widget> widgets = [];

    // Add space to the left
    widgets.add(
      Container(
        height: activityHeight,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
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
          height: timeHeight,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: g2,
                width: lineThickness,
              ),
            ),
          ),
        ),
      );
    }

    // Add space at bottom
    widgets.add(
      const SizedBox(
        height: activityHeight,
      ),
    );

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getLines(),
    );
  }
}
