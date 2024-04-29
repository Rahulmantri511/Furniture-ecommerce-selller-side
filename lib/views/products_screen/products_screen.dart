import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_seller_side/controllers/products_controller.dart';
import 'package:furniture_seller_side/services/store_services.dart';
import 'package:furniture_seller_side/views/products_screen/add_product.dart';
import 'package:furniture_seller_side/views/products_screen/products_details.dart';
import 'package:furniture_seller_side/views/widgets/loading_indicator.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => AddProduct());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: purpleColor,
        automaticallyImplyLeading: false,
        title: boldText(text: products, color: white, size: 20.0),
        actions: [
          Center(
            child: normalText(
                text:
                    intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
                color: white),
          ),
          10.widthBox,
        ],
      ),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                      data.length,
                      (index) => ListTile(
                            onTap: () {
                              Get.to(() => ProductDeatils(data: data[index]));
                            },
                            leading: Image.network(
                              data[index]['p_imgs'][0],
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            title: boldText(
                                text: "${data[index]['p_name']}",
                                color: fontGrey),
                            subtitle: Row(
                              children: [
                                normalText(
                                    text: "₹ ${data[index]['p_price']}",
                                    color: darkGrey),
                                10.widthBox,
                                boldText(
                                    text: data[index]['is_featured'] == true
                                        ? "Featured"
                                        : '',
                                    color: green)
                              ],
                            ),
                            trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                child: Icon(Icons.more_vert_rounded),
                                menuBuilder: () => Column(
                                      children: List.generate(
                                          popupMenuTitles.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Icon(popupMenuIcons[i],
                                                    color: data[index]['feature_id'] == currentUser!.uid && i == 0 ? green : darkGrey,
                                                    ),
                                                    10.widthBox,
                                                    normalText(
                                                        text: data[index]['feature_id'] == currentUser!.uid && i == 0 ? 'Remove featured'
                                                            : popupMenuTitles[i],
                                                        color: darkGrey)
                                                  ],
                                                ).onTap(() {
                                                  switch(i){
                                                    case 0:
                                                      if(data[index]['is_featured'] == true){
                                                        controller.removeFeatured(data[index].id);
                                                        VxToast.show(context, msg: 'Removed');
                                                      } else{
                                                        controller.addFeatured(data[index].id);
                                                        VxToast.show(context, msg: 'Added');
                                                      }
                                                      break;
                                                    case 1:
                                                      break;
                                                    case 2:
                                                      controller.removeProduct(data[index].id);
                                                      VxToast.show(context, msg: "Product removed");
                                                  }
                                                }),
                                              )),
                                    ).box.white.rounded.width(200).make(),
                                clickType: VxClickType.singleClick),
                          )),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
