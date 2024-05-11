
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {

  User? _signedIn;

  // bool get signedIn => _signedIn != null;
  bool get signedIn => true;

  set currentUser(User? newValue) {
    if (_signedIn != newValue) {
      _signedIn = newValue;
      notifyListeners();
    }
  }

}