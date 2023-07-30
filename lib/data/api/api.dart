

import 'package:dio/dio.dart' as d;

String baseUrl = "https://house-booking-api.fly.dev";
d.Dio dio = d.Dio();
d.Options? options;


enum Methode
{
// ignore: constant_identifier_names
GET,
// ignore: constant_identifier_names
POST,
// ignore: constant_identifier_names
DELETE,
// ignore: constant_identifier_names
PATCH
}
// we put the patch instead of put  cause :
// patch update a specific field
// put completely replace or update a resource(whole )