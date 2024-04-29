import 'package:furniture_seller_side/views/widgets/text_style.dart';

import '../../const/const.dart';

class ProductDeatils extends StatelessWidget {
  final dynamic data;
  const ProductDeatils({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}",color: fontGrey,size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data['p_imgs'].length,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return  Image.network(
                  data['p_imgs'][index],
                    // widget.data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and details section
                  boldText(text: "${data['p_name']}",color: fontGrey,size: 16.0),
                  // widget.title!.text.size(20).color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  // Rating
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      Text(
                        "₹ ",
                        style: TextStyle(color: red, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                      boldText(text: "${data['p_price']}",color: red,size: 18.0)
                    ],
                  ),
                  20.heightBox,
                   Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Color",color: fontGrey),
                              // child: "Color: ".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                data['p_colors'].length,
                                    (index) =>
                                    VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index]))
                                        // .color(Color(widget.data['p_colors'][index]).withOpacity(1.0))
                                        .margin(EdgeInsets.symmetric(horizontal: 4))
                                        .make()
                                        .onTap(() {
                                      // controller.changeColorIndex(index);
                                    }),

                              ),
                            ),

                          ],
                        ),
                        10.heightBox,
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Quantity",color: fontGrey),
                              // child: "Quantity: ".text.color(textfieldGrey).make(),
                            ),
                            normalText(text: "${data['p_quantity']}",color: fontGrey)
                            ]
                        )

                      ],
                    ).box.white.padding(EdgeInsets.all(8)).shadowSm.make(),
                  Divider(),
                  20.heightBox,
                  // Description section
                  boldText(text: "Description",color: fontGrey),
                  // "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  normalText(text: "${data['p_description']}",color: fontGrey)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
