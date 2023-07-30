import 'package:intl/intl.dart';

import 'offer.dart';

class Rating {
  int? id;
  String? comment;
  double? stars;
  DateTime? createdAt;
  Offer? offer;

  Rating({this.id, this.comment, this.stars, this.createdAt, this.offer});

  factory Rating.fromMap(Map<String, dynamic> json) {
    return Rating(
        id: json['id'],
        comment: json['comment'],
        stars: json['stars'],
        createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss')
            .parse(json['created_at'].replaceAll('.000Z', '')),
        offer: Offer.fromMap(json['offer']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'comment': comment, 'offer': offer?.id};
  }
}
