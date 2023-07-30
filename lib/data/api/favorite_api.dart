import 'dart:convert';

import 'package:dio/dio.dart';

import '../../models/favorite.dart';
import 'api.dart';

class FavoriteApi {
  Future<List<Map<String, dynamic>>?> getFavorites({String? userId}) async {
    String apiUrl = '$baseUrl/houses/fetch_favorites/$userId';
    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return [...response.data['favorite']];
  }

  Future<Map<String, dynamic>?> addFavorite(
      {Map<String, dynamic>? json}) async {
    String apiUrl = '$baseUrl/houses/create_favorite';

    print('the json fi is ${json}');
    Response response = await dio
        .post(
      apiUrl,
      data: json,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return response.data['data'];
  }

  Future<Response> deleteFavoriteItem(String favoriteId) async {
    String apiUrl = '$baseUrl/houses/favorites/$favoriteId/';

    Response response = await dio
        .delete(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return response;
  }
}
