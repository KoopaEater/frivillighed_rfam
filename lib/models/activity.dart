class Activity {
  final String category;
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  Activity({required this.category, required this.title, required this.startTime, required this.endTime});

  @override
  String toString() => '${category}:${title}';
}

class ActivityException implements Exception {
  final Activity activity;
  final String msg;

  ActivityException(this.activity, this.msg);

  @override
  String toString() => 'ActivityException: on $activity, $msg';
}