import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';

Widget orderPlacedDetails({ title1, title2, d1, d2}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1",color: purpleColor),
            boldText(text: "$d1",color: red),

          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2",color: purpleColor),
              boldText(text: "$d2",color: red),
            ],
          ),
        ),
      ],
    ),
  );
}