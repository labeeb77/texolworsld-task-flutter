import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_session/audio_session.dart';
import 'package:texoworld_chat_task/module/home/controllers/chat_controller.dart';
import 'dart:io';

import 'package:texoworld_chat_task/module/home/controllers/file_upload_controller.dart';


class InputWidget extends StatefulWidget {
  InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final FileUploadController fileController = Get.put(FileUploadController());
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.find<ChatController>();
  
  FlutterSoundRecorder? _recorder;
  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

Future<void> _initRecorder() async {
  _recorder = FlutterSoundRecorder();
  

  print("Requesting microphone permission...");
  
final status = await Permission.microphone.request();
print("Microphone permission status: $status");

if (status != PermissionStatus.granted) {
  print('Microphone permission not granted');
  throw RecordingPermissionException('Microphone permission not granted');
}

  try {
    await _recorder!.openRecorder();
    print("Recorder successfully opened");
    
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    setState(() {
      _isRecorderInitialized = true;
    });
    print("Recorder initialized successfully");

  } catch (e) {
    print('Error initializing recorder: $e');

  }
}

Future<void> _startRecording() async {
  if (!_isRecorderInitialized) {
    print("Recorder is not initialized");
    return;
  }

  try {
    Directory tempDir = await getTemporaryDirectory();
    _recordedFilePath = '${tempDir.path}/recorded_audio.aac';
    print("Starting recording...");
    
    await _recorder!.startRecorder(
      toFile: _recordedFilePath,
      codec: Codec.aacADTS,
    );
    setState(() => _isRecording = true);
    print("Recording started");
  } catch (e) {
    print('Error starting recording: $e');
  }
}

Future<void> _stopRecording() async {
  if (!_isRecorderInitialized) {
    print("Recorder is not initialized");
    return;
  }

  try {
    print("Stopping recording...");
    await _recorder!.stopRecorder();
    setState(() => _isRecording = false);
    print("Recording stopped");
  } catch (e) {
    print('Error stopping recording: $e');
  }
}
  void _deleteRecording() {
    if (_recordedFilePath != null) {
      File(_recordedFilePath!).deleteSync();
      setState(() => _recordedFilePath = null);
    }
  }

  void _sendAudioMessage({bool asOrder = false}) {
    if (_recordedFilePath != null) {
      chatController.addAudioMessage(_recordedFilePath!, asOrder: asOrder);
      setState(() => _recordedFilePath = null);
    }
  }

  void _sendTextMessage() {
    if (messageController.text.isNotEmpty) {
      chatController.addTextMessage(messageController.text);
      messageController.clear();
    }
  }

  void _sendFileMessage() {
    if (fileController.selectedFile.value != null) {
      chatController.uploadFile(fileController.selectedFile.value!.path);
      fileController.removeFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Obx(() {
            return fileController.selectedFile.value != null
                ? _buildFilePreview()
                : const SizedBox.shrink();
          }),
          if (_recordedFilePath != null && !_isRecording)
            _buildAudioPreview(),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type here...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.attach_file, color: Colors.blue),
                        onPressed: fileController.pickFile,
                      ),
                    ],
                  ),
                ),
              ),
                    Obx(() {
                return GestureDetector(
               onTap: () {
                    if (fileController.selectedFile.value != null) {
                   
                      chatController.uploadFile(fileController.selectedFile.value!.path);
                      fileController.removeFile(); 
                    } else if (messageController.text.isNotEmpty) {
                   
                      chatController.addTextMessage(messageController.text);
                      messageController.clear(); 
                      _startRecording();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: fileController.selectedFile.value != null
                          ? const Icon(Icons.send, color: Colors.white)
                          : messageController.text.isNotEmpty ?
                          const Icon(Icons.send, color: Colors.white)
                           : const Icon(Icons.mic_none_outlined, color: Colors.white),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              fileController.selectedFile.value!.path.split('/').last,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: fileController.removeFile,
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPreview() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  
                },
              ),
              Expanded(
                child: Slider(
                  value: 0, 
                  onChanged: (value) {
                   
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: _deleteRecording,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Send as Chat'),
                onPressed: () => _sendAudioMessage(),
              ),
              ElevatedButton(
                child: const Text('Send as Order'),
                onPressed: () => _sendAudioMessage(asOrder: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }
}