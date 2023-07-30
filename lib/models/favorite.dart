import 'package:house_booking/models/user.dart';
import 'package:intl/intl.dart';

import 'offer.dart';

class Favorite {
  String? id;
  DateTime? createdAt;
  Offer? offer;
  User? user;

  Favorite({this.id, this.createdAt, this.offer, this.user});


  factory Favorite.fromMap(Map<String, dynamic> json) {
    return Favorite(
        id: json['id'],
        createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['created_at'].replaceAll('.000Z', '')),
        offer: Offer.fromMap(json['offer']),
        user: User.fromMap(json['user'])

    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'Offer':offer?.id ,
      'user': user?.id,
    } ;

  }

}