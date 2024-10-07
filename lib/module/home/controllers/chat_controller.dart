import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:texoworld_chat_task/data/models/message_model.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    messages.add(
      Message(
        type: MessageType.audio,
        content: '',
        audioUrl: 'https://example.com/audio.mp3',
        transcript: 'This is the transcript of the message. It is expandable and can show more content when clicked.',
        orderNumber: 'Order No: 15544',
        approvalStatus: 'Approved by DP on 02:30pm, 15/07/2024',
        time: '12:38 pm',
      ),
    );
  }

  void addTextMessage(String text) {
    messages.add(
      Message(
        type: MessageType.text,
        content: text,
        time: DateTime.now().toLocal().toString(),
      ),
    );
  }

  Future<void> uploadFile(String filePath) async {
    final fileName = filePath.split('/').last;
    final messageIndex = messages.length;
    
    messages.add(
      Message(
        type: MessageType.file,
        content: fileName,
        time: DateTime.now().toLocal().toString(),
        isUploading: true,
        uploadProgress: 0.0,
        isUploaded: false,
      ),
    );

    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      messages[messageIndex] = messages[messageIndex].copyWith(
        uploadProgress: i / 10,
      );
    }

    messages[messageIndex] = messages[messageIndex].copyWith(
      isUploading: false,
      isUploaded: true,
    );
  }

  Future<void> addAudioMessage(String audioFilePath, {bool asOrder = false}) async {
    final fileName = audioFilePath.split('/').last;
    final messageIndex = messages.length;
    
    messages.add(
      Message(
        type: MessageType.audio,
        content: fileName,
        audioUrl: audioFilePath,
        time: DateTime.now().toLocal().toString(),
        isUploading: true,
        uploadProgress: 0.0,
        isUploaded: false,
        transcript: asOrder ? 'Generating transcript...' : null,
        orderNumber: asOrder ? 'Processing order...' : null,
      ),
    );

    // Simulate upload process
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      messages[messageIndex] = messages[messageIndex].copyWith(
        uploadProgress: i / 10,
      );
    }

    // Simulate processing for orders
    if (asOrder) {
      await Future.delayed(const Duration(seconds: 2));
      messages[messageIndex] = messages[messageIndex].copyWith(
        transcript: 'This is a generated transcript for the order.',
        orderNumber: 'Order No: ${DateTime.now().millisecondsSinceEpoch}',
        approvalStatus: 'Pending approval',
      );
    }

    messages[messageIndex] = messages[messageIndex].copyWith(
      isUploading: false,
      isUploaded: true,
    );
  }
}
