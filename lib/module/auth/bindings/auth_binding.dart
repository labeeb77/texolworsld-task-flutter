import 'package:get/get.dart';
import 'package:texoworld_chat_task/module/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}