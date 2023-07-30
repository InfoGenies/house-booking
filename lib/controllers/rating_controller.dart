import 'package:get/get.dart';

import '../data/repository/rating_repository.dart';
import '../models/Rating.dart';

class RatingController extends GetxController with RatingRepository {
  List<Rating> ratings = [];
  bool canRate = false;
  bool isChecking = false;
  bool isLoading = true;
  String houseId = '';

  final String rateWidgetId = 'rateWidgetId';

  bool get isEmpty => ratings.isEmpty;

  Future<void> getData() async {
    // changeLoadingState(true);

    List<Rating>? resualt = await super.getHouseRatings(
        houseId: houseId
    );

    ratings.addAll(resualt ?? []);

    // changeLoadingState(false);
  }

  @override
  Future<void> initData() async {
    List<Rating>? resualt = await super.getHouseRatings(
      houseId: houseId,
    );
    ratings = resualt ?? [];
  }

/* @override
  Future<Rating?> ratingOnHouse({required Rating rating}) async {
    isLoading = true;
    update([rateWidgetId]);
    Rating? resualt;

    try {
      resualt = await super.ratingOnHouse(rating: rating);

      MessagesController messagesController = Get.find<MessagesController>();
      messagesController.parameters!.offer!.rated = true;
      await messagesController.initData(
        parameters: messagesController.parameters,
      );
      messagesController.changeLoadingState(false);
    } on DioError catch (e) {
      Get.snackbar(
        '',
        '',
        messageText: Text((e.response ?? '').toString()),
        titleText: const SizedBox(),
      );
    }

    isLoading = false;
    update([rateWidgetId]);
    return resualt;
  }
}*/

}