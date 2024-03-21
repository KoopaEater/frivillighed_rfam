
import 'package:flutter/material.dart';
import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/models/event.dart';

class MainProvider extends ChangeNotifier {

  Event? _chosenEvent;
  List<Activity>? _activities;

  Event? get chosenEvent => _chosenEvent;
  List<Activity>? get activities => _activities;

  set chosenEvent(Event? newValue) {
    if (_chosenEvent != newValue) {
      _chosenEvent = newValue;
      notifyListeners();
    }
  }

  set activities(List<Activity>? newValue) {
    if (_activities != newValue) {
      _activities = newValue;
      notifyListeners();
    }
  }

}