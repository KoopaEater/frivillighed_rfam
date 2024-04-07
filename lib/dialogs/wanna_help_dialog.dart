import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';
import 'package:frivillighed_rfam/dialogs/error_dialog.dart';
import 'package:frivillighed_rfam/dialogs/general_dialog.dart';
import 'package:frivillighed_rfam/dialogs/time_picker.dart';
import 'package:frivillighed_rfam/providers/main_provider.dart';
import 'package:provider/provider.dart';

class WannaHelpDialog extends StatefulWidget {
  const WannaHelpDialog({super.key});

  @override
  State<WannaHelpDialog> createState() => _WannaHelpDialogState();
}

class _WannaHelpDialogState extends State<WannaHelpDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  final RegExp _nameRegExp = RegExp(r"^[a-zA-ZÆØÅæøå ,.'-]+$");
  final RegExp _phoneRegExp = RegExp(r'^(?:\+\d{1,3}\s?)?[\d\s-]+$');

  late TimeOfDay fromTime;
  late TimeOfDay toTime;

  @override
  void initState() {
    fromTime = TimeOfDay.fromDateTime(
      DateTime.now(),
    );
    toTime = TimeOfDay.fromDateTime(
      DateTime.now().add(const Duration(hours: 1)),
    );

    super.initState();
  }

  DateTime timeOfDayToDateTime(TimeOfDay time) {
    final eventDateTime =
        Provider.of<MainProvider>(context, listen: false).chosenEvent!.date;
    final result = eventDateTime.copyWith(hour: time.hour, minute: time.minute);
    return result;
  }

  Widget _buildTitle() {
    return const Text(
      "Jeg vil bare gerne hjælpe",
      style: titleTextStyle,
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary),
          ),
          child: const Text("Annuller"),
        ),
        const SizedBox(
          width: buttonSpacing,
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final fromDateTime = timeOfDayToDateTime(fromTime);
              final toDateTime = timeOfDayToDateTime(toTime);

              if (fromDateTime.isAfter(toDateTime)) {
                showDialog(
                  context: context,
                  builder: (context) => const ErrorDialog(
                    title: "Indtast gyldigt tidsrum",
                    message:
                        "Sluttidspunktet skal lægge efter starttidspunktet",
                  ),
                );
              } else {
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text("Meld dig!"),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: "Fulde navn",
              border: dialogBoxBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Skriv venligst et navn";
              }
              if (!_nameRegExp.hasMatch(value)) {
                return "Skriv venligst et gyldigt navn";
              }
              return null;
            },
          ),
          const SizedBox(
            height: dialogSmallSpacing,
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
              if (!_phoneRegExp.hasMatch(value)) {
                return "Skriv venligst et gyldigt telefonnummer";
              }
              return null;
            },
          ),
          const SizedBox(
            height: dialogSpacing,
          ),
          const Text(
            "I hvilket tidsrum kan du hjælpe?",
            style: subtitleTextStyle,
          ),
          const SizedBox(
            height: dialogSmallSpacing,
          ),
          _buildTimeSelectors(),
          const SizedBox(
            height: dialogSmallSpacing,
          ),
          SizedBox(
            height: remarksBoxHeight,
            child: TextFormField(
              controller: _remarksController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                labelText: "Bemærkninger (valgfrit)",
                border: dialogBoxBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelectors() {
    return Row(
      children: [
        TimePicker(
          title: "Vælg tidspunkt (fra)",
          initialTime: fromTime,
          onChange: (time) {
            fromTime = time;
          },
        ),
        const SizedBox(
          width: timeBoxSpacing,
        ),
        const Text("til"),
        const SizedBox(
          width: timeBoxSpacing,
        ),
        TimePicker(
          title: "Vælg tidspunkt (til)",
          initialTime: toTime,
          onChange: (time) {
            toTime = time;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      title: _buildTitle(),
      body: _buildForm(),
      actions: _buildActions(),
    );
  }
}
