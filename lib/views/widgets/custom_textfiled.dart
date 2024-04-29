import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/controllers/products_controller.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';

Widget customTextField({label,hint,TextEditingController? controller,isDesc = false}){
  return TextFormField(
    controller: controller,
    style: TextStyle(color: purpleColor),
    maxLines: isDesc ? 4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label,color: purpleColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: purpleColor
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: purpleColor)
      ),
      hintText: hint,
      hintStyle: TextStyle(color: purpleColor)
    ),
  );
}