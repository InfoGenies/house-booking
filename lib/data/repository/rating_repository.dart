import 'package:dio/dio.dart';

import '../../models/Rating.dart';
import '../api/rating_api.dart';

class RatingRepository {
  RatingApi ratingAPI = RatingApi();

  Future<List<Rating>?> getHouseRatings({
    required String houseId,
    int page = 1,
  }) async {
    List<Map<String, dynamic>>? data = await ratingAPI.getHouseRatings(
      houseId: houseId,
      page: page,
    );
    List<Rating> ratings = [];
    data?.forEach((element) {
      ratings.add(Rating.fromMap(element));
    });

    return ratings;
  }

  Future<Rating?> ratingOnHouse({
    required Rating rating,
  }) async {
    FormData data = FormData.fromMap(rating.toJson());
    Map<String, dynamic>? responseData = await ratingAPI.ratingOnHouse(
      data: data,
    );
    if (responseData != null) {
      Rating responseRating = Rating.fromMap(responseData);
      return responseRating;
    }
    return null;
  }

}