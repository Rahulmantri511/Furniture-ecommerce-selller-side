import 'package:furniture_seller_side/const/const.dart';

Widget productImages({required label,onPress}){
  return "$label".text.bold.color(fontGrey).makeCentered().box.color(lightGrey).size(100,100).roundedSM.make();
}