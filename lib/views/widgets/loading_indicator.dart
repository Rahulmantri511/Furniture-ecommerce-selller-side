import 'package:furniture_seller_side/const/const.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({circleColor = purpleColor}){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),
  );
}