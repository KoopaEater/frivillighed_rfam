import 'package:frivillighed_rfam/models/activity.dart';
import 'package:frivillighed_rfam/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frivillighed_rfam/models/volunteer.dart';
import 'package:frivillighed_rfam/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  final _firestore = FirebaseFirestore.instance;

  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal();

  Future<List<Event>> getEvents() async {
    List<Event> events = [];

    QuerySnapshot querySnapshot = await _firestore.collection("Events").get();

    for (QueryDocumentSnapshot snap in querySnapshot.docs) {
      final data = snap.data() as Map<String, dynamic>;
      try {
        Event e = Event(
          id: snap.id,
          name: data["name"],
          date: data["date"].toDate(),
        );
        events.add(e);
      } catch (e) {
        print("Error happened when fetching event: $e");
      }
    }

    return events;
  }

  Future<List<Activity>> getActivities(String eventId) async {
    List<Activity> activities = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection("Activities")
        .where("event", isEqualTo: eventId)
        .get();

    for (QueryDocumentSnapshot snap in querySnapshot.docs) {
      final data = snap.data() as Map<String, dynamic>;
      try {
        Activity a = Activity(
          id: snap.id,
          category: data["category"],
          title: data["title"],
          startTime: data["start_time"].toDate(),
          endTime: data["end_time"].toDate(),
          tasks: await getTasks(snap.id),
        );
      } catch (e) {
        print("Error happened when fetching activity: $e");
      }
    }

    return activities;
  }

  Future<List<Task>> getTasks(String activityId) async {
    List<Task> tasks = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection("Tasks")
        .where("activity", isEqualTo: activityId)
        .get();

    for (QueryDocumentSnapshot snap in querySnapshot.docs) {
      final data = snap.data() as Map<String, dynamic>;
      try {
        Task t = Task(
          id: snap.id,
          title: data["title"],
          editable: data["editable"],
          maxVolunteers: data["max_volunteers"],
          volunteers: await getVolunteers(snap.id),
        );
        tasks.add(t);
      } catch (e) {
        print("Error happened when fetching task: $e");
      }
    }

    return tasks;
  }

  Future<List<Volunteer>> getVolunteers(String taskId) async {
    List<Volunteer> volunteers = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection("Volunteers")
        .where("task", isEqualTo: taskId)
        .get();

    for (QueryDocumentSnapshot snap in querySnapshot.docs) {
      final data = snap.data() as Map<String, dynamic>;
      try {
        Volunteer v = Volunteer(
          name: data["full_name"],
          phone: data["phone"],
        );
        volunteers.add(v);
      } catch (e) {
        print("Error happened when fetching volunteer: $e");
      }
    }

    return volunteers;
  }
}
