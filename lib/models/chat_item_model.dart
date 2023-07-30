import 'package:house_booking/models/user.dart';

import 'offer.dart';

class ChatItemModel {
  User? user;
  Offer? offer;

  ChatItemModel({
    this.user,
    this.offer,
  });

  factory ChatItemModel.fromMap(Map<String, dynamic> json) {
    return ChatItemModel(
      offer: Offer.fromMap(json['offer']),
      user: User.fromMap(json['user'])
    );
  }
}
