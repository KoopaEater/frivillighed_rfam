
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frivillighed_rfam/table/activity_table.dart';
import 'package:single_child_two_dimensional_scroll_view/single_child_two_dimensional_scroll_view.dart';

class ActivitiesScreen extends StatelessWidget {
  static const id = "activities";

  final hScrollCtr = ScrollController();
  final vScrollCtr = ScrollController();

  ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frivillighed RFAM'),
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: vScrollCtr,
          child: Scrollbar(
            controller: hScrollCtr,
            child: SingleChildTwoDimensionalScrollView(
              verticalController: vScrollCtr,
              horizontalController: hScrollCtr,
              child: const ActivityTable(
                activityLabels: ["Løb", "Længdespring", "Højdespring", "Stangspring", "Kuglestød", "Bod"],
                timeLabels: ["8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
