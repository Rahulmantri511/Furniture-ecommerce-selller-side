import 'package:furniture_seller_side/const/const.dart';

Widget bgWidget(Widget? child){
  return Container(
    decoration: const BoxDecoration(
      image:DecorationImage(image: AssetImage("assets/icons/bg1.png"),fit: BoxFit.fill),
    ),
    child: child,
  );
}