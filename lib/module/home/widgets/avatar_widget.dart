import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20, 
      backgroundImage: AssetImage(
          'assets/images/depositphotos_54357355-stock-photo-handsome-young-black-man-smiling.jpg'), // Asset image path
    );
  }
}
