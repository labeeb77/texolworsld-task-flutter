import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:texoworld_chat_task/module/home/controllers/chat_controller.dart';
import 'package:texoworld_chat_task/module/home/controllers/file_upload_controller.dart';
import 'package:texoworld_chat_task/module/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ChatController());
  
  }
}