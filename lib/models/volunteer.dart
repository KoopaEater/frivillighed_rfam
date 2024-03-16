class Volunteer {

  final String name;
  final String phone;

  Volunteer({required this.name, required this.phone});

  @override
  String toString() => "$name ($phone)";

}