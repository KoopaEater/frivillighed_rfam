import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/dialogs/dialog_constants.dart';
import 'package:frivillighed_rfam/dialogs/error_dialog.dart';
import 'package:frivillighed_rfam/dialogs/general_dialog.dart';
import 'package:frivillighed_rfam/helpers/authentication_helper.dart';
import 'package:frivillighed_rfam/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class AdminLoginDialog extends StatefulWidget {
  const AdminLoginDialog({super.key});

  @override
  State<AdminLoginDialog> createState() => _AdminLoginDialogState();
}

class _AdminLoginDialogState extends State<AdminLoginDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;
  bool _loading = false;

  Future<void> login() async {

    setState(() {
      _loading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      await AuthenticationHelper().signIn(username, password);
      Provider.of<AuthenticationProvider>(context, listen: false).currentUser = AuthenticationHelper().currentUser;
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-credential":
          await showDialog(
            context: context,
            builder: (BuildContext errorContext) =>
                const ErrorDialog(
                  title: "Ugyldigt login",
                  message: "Det indtaste brugernavn eller kodeord er ugyldigt",
                ),
          );
          break;
        default:
          await showDialog(
            context: context,
            builder: (BuildContext errorContext) =>
                const ErrorDialog(
                  title: "Fejl under login",
                  message: "Der skete en fejl, da vi forsøgte at logge dig ind",
                ),
          );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext errorContext) =>
            ErrorDialog(
              title: "Fejl under login",
              message: "Der skete en fejl, da vi forsøgte at logge dig ind",
            ),
      );
      print(e);
    }

    setState(() {
      _loading = false;
    });

  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: dialogSmallSpacing,
          ),
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Brugernavn",
              border: dialogBoxBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Skriv venligst et navn";
              }
              return null;
            },
          ),
          SizedBox(
            height: dialogSmallSpacing,
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _hidePassword,
            decoration: InputDecoration(
              labelText: "Kodeord",
              border: dialogBoxBorder,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                child: Icon(
                  _hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Skriv venligst et navn";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    List<Widget> childrenUploading = [
      const CircularProgressIndicator(),
    ];

    List<Widget> childrenNormal = [
      FilledButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary),
        ),
        child: const Text("Annuller"),
      ),
      const SizedBox(
        width: buttonSpacing,
      ),
      FilledButton(
        onPressed: () {
          login();
        },
        child: const Text("Log ind"),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _loading ? childrenUploading : childrenNormal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      title: Text(
        "Log ind som Admin",
        style: titleTextStyle,
      ),
      actions: _buildButtons(),
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildForm(),
        ],
      ),
    );
  }
}
