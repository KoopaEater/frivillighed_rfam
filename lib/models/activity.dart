import 'package:frivillighed_rfam/models/task.dart';

class Activity {
  final String id;
  final String category;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final List<Task> tasks;
  final bool full;

  Activity({required this.id, required this.category, required this.title, required this.startTime, required this.endTime, required this.tasks, required this.full});

  @override
  String toString() => '$category:$title';

  String get formattedStartTime => "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
  String get formattedEndTime => "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
}

class ActivityException implements Exception {
  final Activity activity;
  final String msg;

  ActivityException(this.activity, this.msg);

  @override
  String toString() => 'ActivityException: on $activity, $msg';
}