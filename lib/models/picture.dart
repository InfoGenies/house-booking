class Picture {
  String? id;
  String picture;
  bool isUrl;

  Picture({this.id, required this.picture , this.isUrl = true});

  factory Picture.fromMap(Map<String, dynamic> json) {
    return Picture(id: json['_id'], picture: json['picture']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'picture': picture};
  }
}
