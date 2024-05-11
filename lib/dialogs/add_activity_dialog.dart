import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';
import 'package:frivillighed_rfam/dialogs/general_dialog.dart';
import 'package:frivillighed_rfam/dialogs/new_category_dialog.dart';
import 'package:frivillighed_rfam/helpers/activity_helper.dart';
import 'package:frivillighed_rfam/providers/main_provider.dart';
import 'package:provider/provider.dart';

class AddActivityDialog extends StatefulWidget {
  const AddActivityDialog({super.key});

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  final _formKey = GlobalKey<FormState>();

  String? chosenCategory;

  bool uploading = false;

  Widget _buildActions() {
    List<Widget> childrenUploading = [
      const CircularProgressIndicator(),
    ];

    List<Widget> childrenNormal = [
      FilledButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: const Text("Annuller"),
      ),
      const SizedBox(
        width: buttonSpacing,
      ),
      FilledButton(
        onPressed: () {
          // NOGET
        },
        child: const Text("Tilføj"),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: uploading ? childrenUploading : childrenNormal,
    );
  }

  List<DropdownMenuItem> _getDropdownItems() {
    final activities = Provider.of<MainProvider>(context).activities;
    List<DropdownMenuItem> items = [];

    items.add(
      const DropdownMenuItem(
        value: "new",
        child: Text("Ny kategori"),
      ),
    );

    if (activities == null) {
      return items;
    }

    final categories = ActivityHelper().getActivityLabels(activities);

    for (String category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category),
        ),
      );
    }

    return items;
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(border: dialogBoxBorder),
            hint: const Text("Vælg kategori"),
            items: _getDropdownItems(),
            value: chosenCategory,
            onChanged: (newTask) async {
              if (newTask == "new") {
                await showDialog(
                  context: context,
                  builder: (context) => NewCategoryDialog(
                    onAdd: (newCategory) {
                      if (newCategory == null) {
                        setState(() {
                          chosenCategory = null;
                        });
                      }
                      print(newCategory);
                    },
                  ),
                );
              }
            },
            validator: (value) {
              // Check noget
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      title: Text(
        "Ny aktivitet",
        style: titleTextStyle,
      ),
      body: _buildForm(),
      actions: _buildActions(),
    );
  }
}
