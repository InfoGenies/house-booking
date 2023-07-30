import 'package:house_booking/models/picture.dart';
import 'package:house_booking/models/user.dart';
import 'package:intl/intl.dart';

import 'municipality.dart';

class House {
  String? id;
  String? houseType;
  String? title;
  String? description;
  int? rooms;
  int? bathrooms;
  int? kitchens;
  int? bedrooms;
  double? locationLatitude;
  double? locationLongitude;
  bool? isAvailable;
  double? stars;
  int? numReviews;
  DateTime? createdAt;
  User? owner;
  Municipality? municipality;
  List<Picture> pictures = [];

  House(
      {this.id,
      this.houseType,
      this.title,
      this.description,
      this.rooms,
      this.bathrooms,
      this.kitchens,
      this.bedrooms,
      this.locationLatitude,
      this.locationLongitude,
      this.isAvailable,
      this.stars,
      this.numReviews,
      this.createdAt,
      this.owner,
      this.municipality,
      this.pictures = const []});

  factory House.fromMap(Map<String, dynamic> json) {
    List<dynamic> jsonPictures = json['pictures'];

    return House(
        id: json['_id'],
        houseType: json['houseType'],
        title: json['title'],
        description: json['description'],
        rooms: json['rooms'],
        bathrooms: json['bathrooms'],
        kitchens: json['kitchens'],
        bedrooms: json['bedrooms'],
        locationLatitude: json['locationLatitude'],
        locationLongitude: json['locationLongitude'],
        isAvailable: json['isAvailable'],
        stars: json['stars'].toDouble(),
        numReviews: json['numReviews'],
        createdAt: DateFormat('yyyy-MM-ddTHH:mm:ss')
            .parse(json['createdAt'].replaceAll('.000Z', '')),
        owner: User.fromMap(json['owner']),
        municipality: Municipality.fromMap(json['municipality']),
        pictures: jsonPictures.map((json) => Picture.fromMap(json)).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'houseType': houseType,
      'title': title,
      'description': houseType,
      'rooms': rooms,
      'bathrooms': bathrooms,
      'kitchens': kitchens,
      'bedrooms': bedrooms,
      'location_latitude': locationLatitude,
      'location_longitude': locationLongitude,
      'isAvailable': isAvailable,
      'stars': stars,
      'numReviews': numReviews,
      'municipality': municipality?.id,
      'pictures': pictures.map((picture) => picture.toJson()).toList()
    };
  }
}
