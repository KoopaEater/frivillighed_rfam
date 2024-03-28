import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/dialogs/registration_dialog.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';
import 'package:hovering/hovering.dart';

class ActivityBox extends StatelessWidget {
  final Activity activity;
  final double height;

  const ActivityBox({super.key, required this.activity, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => RegistrationDialog(
              activity: activity,
            ),
          );
        },
        child: HoverContainer(
          width: double.infinity,
          hoverDecoration: BoxDecoration(
            color: activity.full ? acGreyH : acGreenH,
            border: Border.all(
              width: 2.0,
              color: activity.full ? acGreyO : acGreenO,
            ),
            borderRadius: BorderRadius.circular(activityCornerRadius),
          ),
          decoration: BoxDecoration(
            color: activity.full ? acGrey : acGreen,
            border: Border.all(
              width: 2.0,
              color: activity.full ? acGreyO : acGreenO,
            ),
            borderRadius: BorderRadius.circular(activityCornerRadius),
          ),
          margin: const EdgeInsets.only(
            left: activityPadding,
            right: activityPadding + 2,
            top: activityPadding,
          ),
          padding: const EdgeInsets.all(activityContentPadding),
          child: Text(activity.title),
        ),
      ),
    );
  }
}
