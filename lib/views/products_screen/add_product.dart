import 'package:furniture_seller_side/controllers/products_controller.dart';
import 'package:furniture_seller_side/views/products_screen/components/product_dropdown.dart';
import 'package:furniture_seller_side/views/products_screen/components/product_images.dart';
import 'package:furniture_seller_side/views/widgets/custom_textfiled.dart';
import 'package:furniture_seller_side/views/widgets/loading_indicator.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: purpleColor,
          title: boldText(text: "Add Product", color: white, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(
                      text: "Save",
                      color: white,
                    ))
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg Chair",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "eg 1000rs",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "eg 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                customTextField(
                    hint: "eg nice product",
                    label: "Specification",
                    isDesc: true,
                    controller: controller.pspecificationController),
                10.heightBox,
                customTextField(
                    hint: "eg nice product",
                    label: "return policy",
                    isDesc: true,
                    controller: controller.preturnpolicyController),
                10.heightBox,
                customTextField(
                    hint: "eg nice product",
                    label: "seller policy",
                    isDesc: true,
                    controller: controller.psellerpolicyController),
                10.heightBox,
                customTextField(
                    hint: "eg nice product",
                    label: "warranty",
                    isDesc: true,
                    controller: controller.pwarrantyController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                boldText(text: "Choose product images"),
                5.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                width: 100,
                              ).onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: darkGrey),
                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                // Obx(
                //   ()=> Wrap(
                //     spacing: 8.0,
                //     runSpacing: 8.0,
                //     children: List.generate(
                //         9,
                //         (index) => Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             VxBox()
                //                 .color(Vx.randomPrimaryColor)
                //                 .roundedFull
                //                 .size(50, 50)
                //                 .make().onTap(() {
                //                   controller.selectedColorIndex.value = index;
                //             }),
                //             controller.selectedColorIndex.value == index ? Icon(Icons.done,color: white) : SizedBox(),
                //           ],
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
