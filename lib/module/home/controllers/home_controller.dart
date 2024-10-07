import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:texoworld_chat_task/data/providers/local_storage_service.dart';

class HomeController extends GetxController {
  final username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsername();
  }

  void loadUsername() async {
    username.value = await LocalStorageService.getUserId() ?? 'User';
  }

  void logout() async {
    await LocalStorageService.setLoggedIn(false);
    await LocalStorageService.setUserId('');
    Get.offAllNamed('/login');
  }
}