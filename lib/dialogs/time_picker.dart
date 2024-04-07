import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';

class TimePicker extends StatefulWidget {

  final String title;
  final TimeOfDay initialTime;
  final void Function(TimeOfDay) onChange;

  const TimePicker({super.key, required this.title, required this.initialTime, required this.onChange});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay selected;

  @override
  void initState() {
    selected = widget.initialTime;
    super.initState();
  }

  String _getText() => "${selected.hour.toString().padLeft(2, '0')}:${selected.minute.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {

        TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: selected,
          confirmText: "Vælg",
          cancelText: "Tilbage",
          errorInvalidText: "Vælg en gyldig tid",
          hourLabelText: "Time",
          minuteLabelText: "Minut",
          helpText: widget.title,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );

        if (newTime != null) {
          setState(() {
            selected = newTime;
          });
          widget.onChange(newTime);
        }

      },
      shape: dialogBoxBorder,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: SizedBox(
          width: 75.0,
          child: Center(
            child: Text(
              _getText(),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
