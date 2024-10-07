import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final String content;
  final String time;

  const TextMessage({required this.content, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content, style: const TextStyle(fontSize: 16)),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 10,),
                const Icon(Icons.done_all_sharp,size: 19,color: Colors.grey,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}