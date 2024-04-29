import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_seller_side/services/store_services.dart';
import 'package:furniture_seller_side/views/message_screen/chat_screen.dart';
import 'package:furniture_seller_side/views/widgets/loading_indicator.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';


class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
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
                  children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: () {
                        Get.to(() => ChatScreen());
                      },
                      leading: CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      title: boldText(
                          text: "${data[index]['sender_name']}",
                          color: fontGrey),
                      subtitle: normalText(
                          text: "${data[index]['last_msg']}", color: darkGrey),
                      trailing: normalText(text: time, color: darkGrey),
                    );
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
