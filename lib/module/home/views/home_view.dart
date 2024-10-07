import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:texoworld_chat_task/core/utils/time.dart';
import 'package:texoworld_chat_task/data/models/message_model.dart';
import 'package:texoworld_chat_task/module/home/controllers/chat_controller.dart';
import 'package:texoworld_chat_task/module/home/controllers/home_controller.dart';
import 'package:texoworld_chat_task/module/home/widgets/avatar_widget.dart';
import 'package:texoworld_chat_task/module/home/widgets/file_message.dart';
import 'package:texoworld_chat_task/module/home/widgets/sent_message.dart';
import 'package:texoworld_chat_task/module/home/widgets/filterchip_section.dart';
import 'package:texoworld_chat_task/module/home/widgets/input_widget.dart';
import 'package:texoworld_chat_task/module/home/widgets/text_message.dart';

class HomeView extends GetView<ChatController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, 
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        title: Row(
          children: [
            AvatarWidget(),
            const SizedBox(width: 8),
            const Text(
              'Michael Knight',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            children: [
              Divider(
                color: Colors.grey.shade200,
                height: 5,
              ),
              const FilterChipsSection(
                filterOptions: ['Unread', 'Approved', 'Declined', 'Pending'],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat Display 
               Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  if (message.type == MessageType.text) {
                    return TextMessage(content: message.content, time: formatTime(message.time));
                  } else if (message.type == MessageType.file) {
                    return FileMessage(
                      fileName: message.content,
                      time: formatTime(message.time),
                      isUploading: message.isUploading,
                      uploadProgress: message.uploadProgress,
                      isUploaded: message.isUploaded,
                    );
                  } else if (message.type == MessageType.audio) {
                    return SentMessage(
                      audioUrl: message.audioUrl!,
                      transcript: message.transcript ?? '',
                      orderNumber: message.orderNumber ?? '',
                      approvalStatus: message.approvalStatus ?? '',
                      time: formatTime(message.time),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            }),
          ),
           InputWidget(),
        ],
      ),
    );
  }
}
