import 'package:house_booking/models/user.dart';
import 'package:intl/intl.dart';

import 'house.dart';

class Offer {
  String? id;
  String? status;
  int? pricePerDay;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  bool? rated;
  late House house;
  User? user;

  Offer({this.id,
    this.status,
    this.pricePerDay,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.rated,
    required this.house,
    this.user});

  factory Offer.fromMap(Map<String, dynamic> json) {
    return Offer(
        id: json['_id'],
        status: json['status'],
        pricePerDay: json['price_per_day'],
        startDate: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['start_date'].replaceAll('.000Z', '')),
        endDate: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['end_date'].replaceAll('.000Z', '')),
        createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['created_at'].replaceAll('.000Z', '')),
        rated: json['rated'],
        house: House.fromMap(json['house']) ,
        user: User.fromMap(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {
    'status' : status,
    'price_per_day' : pricePerDay,
    'start_date': startDate?.toIso8601String(),
    'end_date' : endDate?.toIso8601String(),
    'rated' : rated,
    'house' : house.id,
    'user' :  user?.id
  };

}


}
