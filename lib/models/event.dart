
class Event {

  final String id;
  final String name;
  final DateTime date;

  Event({required this.id, required this.name, required this.date});

  @override
  String toString() => "$name: $formattedDate";

  String get formattedDate => "${date.day}/${date.month}-${date.year}";

}