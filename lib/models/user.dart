import 'package:intl/intl.dart';

class User {
  final String? id;

  final String? email;

  final String? password;

  final String? username;

  final String? phone;

  final String? picture;

  final String? language;

  final String? location;

  final String? aboutMe;

  final String? userType;

  final DateTime? dateJoined;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.username,
      required this.phone,
      required this.picture,
      required this.language,
      required this.location,
      required this.userType,
      required this.aboutMe,
      required this.dateJoined});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'],
        email: map['email'],
        password: map['password'],
        phone: map['phone'],
        username: map['username'],
        aboutMe: map['aboutMe'],
        userType: map['userType'],
        language: map['language'],
        location: map['location'],
        picture: map['picture'],
        dateJoined: DateFormat('yyyy-MM-ddTHH:mm:ss')
            .parse(map['dateJoined'].replaceAll('.000Z', '')));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'phone': phone,
      'username': username,
      'aboutMe': aboutMe,
      'userType': userType,
      'language': language,
      'location': location,
      'picture': picture,
      'dateJoined': dateJoined,
    };
  }
}
