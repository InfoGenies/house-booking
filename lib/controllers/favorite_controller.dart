import 'package:get/get.dart';

import '../data/repository/favorite_repository.dart';
import '../models/favorite.dart';

class FavoriteController extends GetxController with FavoriteRepository {
  static FavoriteController instance = Get.find();

  List<Favorite> favorites = [];
  bool isLoading = false;
  final String favoriteIconId = 'favoriteIconId';

  bool get isEmpty => favorites.isEmpty;

  @override
  Future<List<Favorite>?> getFavorites(String userId) async {
    changeLoadingState(true);
    try {
      favorites = (await super.getFavorites(userId)) ?? [];
    } catch (e) {
      print(e);
    }

    changeLoadingState(false);
    return favorites;
  }

  Future<Favorite?> addFavorites(String offerId, String userId) async {
    Map<String, dynamic> json = {"offerId": offerId, "userId": userId};
    if (!contains(offerId)) {
      changeLoadingState(true);

      await super.addFavorite(json);

      favorites = (await super.getFavorites(userId)) ?? [];
      update([favoriteIconId]);

      changeLoadingState(false);
    }
    return null;
  }

  Future<bool?> deleteFavoriteItems(String favoriteId, String userId) async {
    bool isDeleted = false;

    try {
      isDeleted = (await super.deleteFavoriteItem(favoriteId)) ?? false;
      favorites = (await super.getFavorites(userId)) ?? [];
    } catch (e) {
      print(e);
    }

    update();
    changeLoadingState(false);
    return isDeleted;
  }

  bool contains(String offerId) =>
      favorites.indexWhere((element) => element.offer?.id == offerId) != -1;

  void changeLoadingState(bool state) {
    isLoading = state;
    update();
  }
}
