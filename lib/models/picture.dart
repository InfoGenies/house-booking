class Picture {
  int? id;
  String picture;
  bool isUrl;

  Picture({this.id, required this.picture , this.isUrl = true});

  factory Picture.fromMap(Map<String, dynamic> json) {
    return Picture(id: json['id'], picture: json['picture']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'picture': picture};
  }
}
