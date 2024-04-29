import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_seller_side/controllers/orders_controller.dart';
import 'package:furniture_seller_side/services/store_services.dart';
import 'package:furniture_seller_side/views/order_screen/order_detail.dart';
import 'package:furniture_seller_side/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleColor,
        automaticallyImplyLeading: false,
        title: boldText(text: orders, color: white, size: 20.0),
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
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(data.length, (index) {

                    var time = data[index]['order_date'].toDate();

                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(data: data[index],));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: intl.DateFormat().add_yMd().format(time), color: fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: "Unpaid", color: red),
                            ],
                          ),
                          //  normalText(text: "₹ 2000", color: darkGrey),
                        ],
                      ),
                      trailing: boldText(
                          text: "₹ ${data[index]['total_amount']}", color: purpleColor, size: 16.0),
                    ).box.margin(EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
