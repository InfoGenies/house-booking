import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/house_controller.dart';
import '../controllers/nav_bar_controller.dart';
import '../controllers/offer_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // Prepare Our Dependency Injection
    Get.lazyPut(() =>  AuthController());
    Get.lazyPut(() =>  NavBarController());
    Get.put<HouseController>(HouseController(),permanent: true);
    Get.lazyPut(() =>  OfferController() , fenix: true);
    Get.put<FavoriteController>(FavoriteController(), permanent: true);

}
}