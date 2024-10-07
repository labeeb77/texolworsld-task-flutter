import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texoworld_chat_task/data/providers/local_storage_service.dart';
import 'package:texoworld_chat_task/routes/app_routes.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 3));
    
    // Check credentials
    if (username == "demo" && password == "12345") {
      // Successful login
      await LocalStorageService.setLoggedIn(true);
      await LocalStorageService.setUserId(username);
      Get.offAllNamed(AppRoutes.home);
    } else {
      // Failed login
      Get.snackbar(
        'Login Failed',
        'Invalid username or password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
    
    isLoading.value = false;
  }

  Future<void> logout() async {
    await LocalStorageService.setLoggedIn(false);
    await LocalStorageService.setUserId('');
    Get.offAllNamed(AppRoutes.login);
  }
}