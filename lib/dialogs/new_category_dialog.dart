import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';
import 'package:frivillighed_rfam/dialogs/general_dialog.dart';

class NewCategoryDialog extends StatefulWidget {
  final void Function(String?) onAdd;

  NewCategoryDialog({super.key, required this.onAdd});

  @override
  State<NewCategoryDialog> createState() => _NewCategoryDialogState();
}

class _NewCategoryDialogState extends State<NewCategoryDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textController = TextEditingController();

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        decoration: InputDecoration(border: dialogBoxBorder),
        controller: _textController,
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton(
          onPressed: () {
            widget.onAdd(null);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: const Text("Annuller"),
        ),
        SizedBox(
          width: buttonSpacing,
        ),
        FilledButton(
          child: const Text("Tilføj"),
          onPressed: () {
            widget.onAdd(_textController.text);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      title: Text(
        "Ny kategori",
        style: titleTextStyle,
      ),
      body: _buildForm(),
      actions: _buildActions(),
    );
  }
}
