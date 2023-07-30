class City {
  String? id;
  String? name;
  String? picture;

  City({this.id, this.name, this.picture});

  factory City.fromMap(Map<String, dynamic> json) {
    return City(id: json['_id'], name: json['name'], picture: json['picture']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'picture': picture};
  }

  @override
  String toString() {
    return name ?? super.toString();
  }
}
// here we check the if picture contain the base url or not
//  picture : !json['picture'].contains(api) ? api + json['picture'] : json['picture']
