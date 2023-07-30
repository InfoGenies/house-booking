import 'package:dio/dio.dart';

import '../../models/favorite.dart';
import '../api/favorite_api.dart';

class FavoriteRepository {

  FavoriteApi  favoriteApi = FavoriteApi() ;


  Future<List<Favorite>?> getFavorites(String userId) async {
    List<Map<String, dynamic>>? data = await favoriteApi.getFavorites(userId: userId);
    List<Favorite> favorites = [];
    for (var element in data!) {
      favorites.add(Favorite.fromMap(element));
    }

    return favorites;
  }

  Future<Map<String, dynamic>?> addFavorite(Map<String,dynamic> json) async {
    Map<String, dynamic>? responseData = await favoriteApi.addFavorite(json:json);
    if (responseData != null) {
      return responseData;
    }
    return null;
  }

  Future<bool?> deleteFavoriteItem(String favoriteId) async {
    Response? response = await favoriteApi.deleteFavoriteItem(favoriteId);
    return response.statusCode == 200 || response.statusCode == 201;
  }

}