import 'package:flutter/material.dart';
import 'package:furniture_seller_side/const/colors.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';

Widget chatBubble({required String message, required String time}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          normalText(text: message),
          SizedBox(height: 10),
          normalText(text: time),
        ],
      ),
    ),
  );
}
