import 'City.dart';

class Municipality {
  String? id;
  String? name;
  City? city;

  Municipality({this.id, this.name, this.city});

  factory Municipality.fromMap(Map<String, dynamic> json) {
    return Municipality(
        id: json['id'],
        name: json['name'],
        city: City.fromMap(json['city']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'city': city?.id};
  }

  @override
  String toString() {
    return name ?? super.toString();
  }
}
