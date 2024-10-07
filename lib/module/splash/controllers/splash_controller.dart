import 'package:get/get.dart';
import 'package:texoworld_chat_task/data/providers/local_storage_service.dart';
import 'package:texoworld_chat_task/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulating some loading time
    bool isLoggedIn = await LocalStorageService.isLoggedIn();
    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
