import 'package:get/get.dart';

import '../data/api/auth/auth_api.dart';

class AuthController extends GetxController with AuthApi {
  static AuthController instance = Get.find();


  Rx<AuthenticationMode> authenticationMode = AuthenticationMode.signIn.obs;

  RxBool isLoading = false.obs;



  Future<void> initData() async {
    await super.init();
    super.getToken();
  }

}


enum AuthenticationMode {
  signIn,
  signUp,
}
