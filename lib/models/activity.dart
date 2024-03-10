class Activity {
  final String category;
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  Activity({required this.category, required this.title, required this.startTime, required this.endTime});

  @override
  String toString() => '${category}:${title}';

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