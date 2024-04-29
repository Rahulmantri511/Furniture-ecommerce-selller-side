import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';

Widget ourButton({title, color = purpleColor, onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: color,
      padding: const EdgeInsets.all(12)
    ),
      onPressed: onPress,
      child: normalText(
          text: title,
          size: 16.0
      )
  );
}