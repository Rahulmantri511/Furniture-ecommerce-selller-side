import 'package:furniture_seller_side/const/const.dart';

Widget normalText({text,color = Colors.white,size = 14.0}){
  return "$text".text.color(color).size(size).make();
}

Widget boldText({text,color = white,size = 14.0}){
  return "$text".text.color(color).size(size).semiBold.make();
}