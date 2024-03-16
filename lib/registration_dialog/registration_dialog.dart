import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/models/task.dart';
import 'package:frivillighed_rfam/registration_dialog/dialog_constants.dart';
import 'package:frivillighed_rfam/registration_dialog/titled_container.dart';

class RegistrationDialog extends StatelessWidget {
  final Activity activity;

  RegistrationDialog({super.key, required this.activity});

  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem> _getDropdownItems() {
    List<DropdownMenuItem> items = [];

    activity.tasks.forEach((title, list) {
      if (list.editable) {
        items.add(
          DropdownMenuItem(
            value: title,
            child: Text(title),
          ),
        );
      }
    });

    return items;
  }

  TitledContainer _buildVolunteerBox(String title, Task list) {
    List<Text> volunteerTexts =
        list.volunteers.map((volunteer) => Text(volunteer.toString())).toList();

    return TitledContainer(
      titleText: title,
      child: Column(
        children: volunteerTexts,
      ),
    );
  }

  Column _buildVolunteerBoxes() {
    List<TitledContainer> boxes = [];

    activity.tasks.forEach((title, volunteers) {
      boxes.add(_buildVolunteerBox(title, volunteers));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: boxes,
    );
  }

  Form _getVolunteerForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: dialogBoxTopPadding,
          ),
          DropdownButtonFormField(
            onChanged: (change) {},
            decoration: InputDecoration(border: dialogBoxBorder),
            items: _getDropdownItems(),
          ),
          SizedBox(
            height: dialogBoxTopPadding,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Fulde navn",
              border: dialogBoxBorder,
            ),
          ),
          SizedBox(
            height: dialogBoxTopPadding,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Telefonnummer",
              border: dialogBoxBorder,
            ),
          ),
        ],
      ),
    );
  }

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
          child: Container(
            width: min(MediaQuery.of(context).size.width, dialogWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Meld dig som frivillig til: ${activity.category}"),
                Text(
                    "Tidspunkt: ${activity.formattedStartTime}-${activity.formattedEndTime}"),
                Text("Beskrivelse: ${activity.title}"),
                _buildVolunteerBoxes(),
                SizedBox(
                  height: dialogSpacing,
                ),
                Text("Meld dig som frivillig:"),
                _getVolunteerForm(),
                SizedBox(
                  height: dialogSpacing,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FilledButton(
                    onPressed: () {
                      print("Pressed");
                    },
                    child: Text("Meld dig!"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
