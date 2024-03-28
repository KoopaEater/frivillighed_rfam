
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/general_dialog.dart';
import 'package:frivillighed_rfam/helpers/database_helper.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/models/event.dart';
import 'package:frivillighed_rfam/models/task.dart';
import 'package:frivillighed_rfam/models/volunteer.dart';
import 'package:frivillighed_rfam/providers/main_provider.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';
import 'package:frivillighed_rfam/dialogs/error_dialog.dart';
import 'package:frivillighed_rfam/dialogs/titled_container.dart';
import 'package:provider/provider.dart';

class RegistrationDialog extends StatefulWidget {
  final Activity activity;

  RegistrationDialog({super.key, required this.activity});

  @override
  State<RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final RegExp _nameRegExp = RegExp(r"^[a-zA-ZÆØÅæøå ,.'-]+$");
  final RegExp _phoneRegExp = RegExp(r'^(?:\+\d{1,3}\s?)?[\d\s-]+$');

  Task? chosenTask;
  bool uploading = false;

  Future<void> uploadVolunteer() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        uploading = true;
      });

      Volunteer v = Volunteer(
        name: _nameController.value.text.trim(),
        phone: _phoneController.value.text.replaceAll(' ', '').trim(),
      );

      final int volunteerCount =
          await DatabaseHelper().getVolunteerCountForTask(chosenTask!.id);

      if (volunteerCount < chosenTask!.maxVolunteers) {

        final bool phoneExists = await DatabaseHelper()
            .existsVolunteerForActivityWithPhone(widget.activity.id, v.phone);

        if (!phoneExists) {
          // SUCCESS
          await DatabaseHelper().uploadVolunteer(v, chosenTask!.id);
        } else {
          // ERROR
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ErrorDialog(
              title: "Fejl ved tilmelding",
              message:
              "Dette telefonnummer er allerede tilmeldt denne aktivitet, og kan ikke tilmeldes igen. Hvis du mener, at dette er en fejl kan du skrive til arrangøren.",
            ),
          );
        }
      } else {
        // ERROR
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ErrorDialog(
            title: "Fejl ved tilmelding",
            message:
                "Det lader til, at nogen har tilmeldt sig denne opgave på samme tid, som dig. Så der er desværre ikke plads. Prøv at vælg en anden opgave.",
          ),
        );
      }

      Event? chosenEvent =
          Provider.of<MainProvider>(context, listen: false).chosenEvent;
      Provider.of<MainProvider>(context, listen: false).activities =
          await DatabaseHelper().getActivities(chosenEvent!.id);

      Navigator.pop(context);

      setState(() {
        uploading = false;
      });
    }
  }

  List<DropdownMenuItem> _getDropdownItems() {
    List<DropdownMenuItem> items = [];

    for (Task task in widget.activity.tasks) {
      if (task.editable && task.volunteers.length < task.maxVolunteers) {
        items.add(
          DropdownMenuItem(
            value: task,
            child: Text(task.title),
          ),
        );
      }
    }

    return items;
  }

  TitledContainer _buildVolunteerBox(Task task) {
    List<Text> volunteerTexts =
        task.volunteers.map((volunteer) => Text(volunteer.toString())).toList();

    return TitledContainer(
      titleText:
          "${task.title} (${task.volunteers.length}/${task.maxVolunteers})",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: volunteerTexts,
      ),
    );
  }

  Column _buildVolunteerBoxes() {
    List<TitledContainer> boxes = [];

    for (Task t in widget.activity.tasks) {
      boxes.add(_buildVolunteerBox(t));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: boxes,
    );
  }

  Form _buildVolunteerForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: dialogBoxTopPadding,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(border: dialogBoxBorder),
            hint: const Text("Vælg en opgave"),
            items: _getDropdownItems(),
            onChanged: (newTask) {
              setState(() {
                chosenTask = newTask;
              });
            },
            validator: (value) {
              if (value == null) {
                return "Vælg venligst en opgave";
              }
              return null;
            },
          ),
          SizedBox(
            height: dialogBoxTopPadding,
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Fulde navn",
              border: dialogBoxBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Skriv venligst et navn";
              }
              if (!_nameRegExp.hasMatch(value as String)) {
                return "Skriv venligst et gyldigt navn";
              }
              return null;
            },
          ),
          SizedBox(
            height: dialogBoxTopPadding,
          ),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "Telefonnummer",
              border: dialogBoxBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Skriv venligst et telefonnummer";
              }
              if (!_phoneRegExp.hasMatch(value as String)) {
                return "Skriv venligst et gyldigt telefonnummer";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (widget.activity.full) {
      return Align(
        alignment: Alignment.topRight,
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Tilbage"),
        ),
      );
    } else {
      List<Widget> childrenUploading = [
        const CircularProgressIndicator(),
      ];

      List<Widget> childrenNormal = [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: const Text("Annuller"),
        ),
        const SizedBox(
          width: buttonSpacing,
        ),
        FilledButton(
          onPressed: () {
            uploadVolunteer();
          },
          child: const Text("Meld dig!"),
        ),
      ];

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: uploading ? childrenUploading : childrenNormal,
      );
    }
  }

  Column _buildRegistration(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meld dig som frivillig!",
          style: subtitleTextStyle,
        ),
        _buildVolunteerForm(),
        SizedBox(
          height: dialogSpacing,
        ),
      ],
    );
  }

  Row _buildTitle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.activity.category,
                style: titleTextStyle,
              ),
              Text(
                widget.activity.title,
                style: subtitleTextStyle,
              ),
            ],
          ),
        ),
        Text(
            "${widget.activity.formattedStartTime} - ${widget.activity.formattedEndTime}"),
        const SizedBox(
          width: iconSpacing,
        ),
        const Icon(Icons.access_time),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildVolunteerBoxes(),
                SizedBox(
                  height: dialogSpacing,
                ),
                widget.activity.full
                    ? const SizedBox()
                    : _buildRegistration(context),
              ],
            ),
          ),
          _buildButtons(context),
        ],
      ),
    );
  }
}
