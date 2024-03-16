import 'package:frivillighed_rfam/models/volunteer.dart';

class Task {

  final String id;
  final String title;
  final bool editable;
  final int maxVolunteers;
  final List<Volunteer> volunteers;

  Task({this.id = "NONE", this.title = "NONE", required this.volunteers, this.maxVolunteers = 10, this.editable = true});

}