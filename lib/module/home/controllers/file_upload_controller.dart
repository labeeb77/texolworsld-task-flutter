import 'dart:io';

import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadController extends GetxController {
  var selectedFile = Rxn<File>();

  // Function to pick a file
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  // Remove selected file
  void removeFile() {
    selectedFile.value = null;
  }
}
