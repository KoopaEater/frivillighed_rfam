import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/table/table_constants.dart';

class RegistrationDialog extends StatelessWidget {
  final Activity activity;

  const RegistrationDialog({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogCornerRadius),
      ),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(dialogPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Meld dig som frivillig til: ${activity.category}"),
              Text(
                  "Tidspunkt: ${activity.formattedStartTime}-${activity.formattedEndTime}"),
              Text("Beskrivelse: ${activity.title}"),
            ],
          ),
        ),
      ),
    );
  }
}
