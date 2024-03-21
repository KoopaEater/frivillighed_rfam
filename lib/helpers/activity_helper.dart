import 'package:frivillighed_rfam/models/activity.dart';

class ActivityHelper {
  static final ActivityHelper _singleton = ActivityHelper._internal();

  factory ActivityHelper() {
    return _singleton;
  }

  ActivityHelper._internal();

  Map<String, List<Activity>> getActivityMap(List<Activity> activities) {
    Map<String, List<Activity>> activityMap = {};
    for (Activity activity in activities) {
      List<Activity>? l = activityMap[activity.category];
      if (l == null) {
        activityMap[activity.category] = [activity];
      } else {
        l.add(activity);
      }
    }
    return activityMap;
  }

  DateTime getMinTime(List<Activity> activities) {
    DateTime minTime = DateTime(3000);
    for (Activity activity in activities) {
      if (activity.startTime.isBefore(minTime)) {
        minTime = activity.startTime;
      }
    }
    return minTime;
  }

  DateTime getMaxTime(List<Activity> activities) {
    DateTime maxTime = DateTime(0);
    for (Activity activity in activities) {
      if (activity.endTime.isAfter(maxTime)) {
        maxTime = activity.endTime;
      }
    }
    return maxTime;
  }

  List<String> getTimeLabels(List<Activity> activities) {

    DateTime minTime = getMinTime(activities);
    DateTime maxTime = getMaxTime(activities);

    List<String> timeLabels = [];
    for (int hour = minTime.hour + 1; hour <= maxTime.hour + 1; hour++) {
      timeLabels.add("$hour:00");
    }
    return timeLabels;
  }

  List<String> getActivityLabels(List<Activity> activities) {
    List<String> activityLabels = [];
    for (Activity activity in activities) {
      if (activityLabels.contains(activity.category)) continue;
      activityLabels.add(activity.category);
    }
    return activityLabels;
  }

  double dateTimeToDecimal(DateTime time) {
    return time.hour + (time.minute / 60);
  }

  double decimalBetweenDateTimes(DateTime from, DateTime to) {
    return dateTimeToDecimal(to) - dateTimeToDecimal(from);
  }

}