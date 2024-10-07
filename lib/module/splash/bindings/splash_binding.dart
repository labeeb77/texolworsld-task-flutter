import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:texoworld_chat_task/module/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
