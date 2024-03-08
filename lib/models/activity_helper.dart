import 'package:frivillighed_rfam/models/activity.dart';

class ActivityHelper {
  static final ActivityHelper _singleton = ActivityHelper._internal();

  factory ActivityHelper() {
    return _singleton;
  }

  ActivityHelper._internal();

  Map<String, Set<Activity>> getActivityMap(Set<Activity> activities) {
    Map<String, Set<Activity>> activityMap = Map();
    for (Activity activity in activities) {
      Set<Activity>? s = activityMap[activity.category];
      if (s != null) {
        s.add(activity);
      } else {
        activityMap[activity.category] = {activity};
      }
    }
    return activityMap;
  }

  DateTime getMinTime(Set<Activity> activities) {
    DateTime minTime = DateTime(3000);
    for (Activity activity in activities) {
      if (activity.startTime.isBefore(minTime)) {
        minTime = activity.startTime;
      }
    }
    return minTime;
  }

  DateTime getMaxTime(Set<Activity> activities) {
    DateTime maxTime = DateTime(0);
    for (Activity activity in activities) {
      if (activity.endTime.isAfter(maxTime)) {
        maxTime = activity.endTime;
      }
    }
    return maxTime;
  }

  List<String> getTimeLabels(Set<Activity> activities) {

    DateTime minTime = getMinTime(activities);
    DateTime maxTime = getMaxTime(activities);

    int minHour = minTime.minute == 0 ? minTime.hour : minTime.hour + 1;
    int maxHour = maxTime.minute == 0 ? maxTime.hour : maxTime.hour + 1;
    List<String> timeLabels = [];
    for (int hour = minHour; hour <= maxHour; hour++) {
      timeLabels.add("$hour:00");
    }
    return timeLabels;
  }

}