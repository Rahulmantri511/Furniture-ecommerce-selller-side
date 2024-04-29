import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/controllers/products_controller.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(hint,List<String> list,dropvalue, ProductsController controller) {
  return Obx(
      ()=> DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: normalText(text: "$hint",color: fontGrey),
          value: dropvalue.value == '' ? null : dropvalue.value,
            isExpanded: true,
            items: list.map((e){
              return DropdownMenuItem(child: e.toString().text.make(),
              value: e,);
            }).toList(),
            onChanged: (newValue) {
            if(hint == "Category"){
              controller.subcategoryvalue.value = '';
             controller.populateSubCategory(newValue.toString());
            }
            dropvalue.value = newValue.toString();
          }
        )
    ).box.p4.white.roundedSM.make(),
  );
}
