import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_seller_side/controllers/auth_controller.dart';
import 'package:furniture_seller_side/views/auth_screen/login_screen.dart';
import 'package:furniture_seller_side/views/message_screen/message_screen.dart';
import 'package:furniture_seller_side/views/review_screen/review_screen.dart';
import 'package:furniture_seller_side/views/widgets/bg_widget.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  @override
  void initState() {
    super.initState();
   // Initialize AuthController
    Get.find<AuthController>().currentUserStream.listen((user) {
      setState(() {
        currentUser = user;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return bgWidget(
        Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: purpleColor,
          title: boldText(text: settings, size: 20.0),
          actions: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signoutMethod(context);
                  Get.offAll(() => LoginScreen());
                },
                child: normalText(text: logout))
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection(vendorsCollection)
                .doc(currentUser!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('User data not found.'));
              }
              final data = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  10.heightBox,
                  ListTile(
                    leading: Image.asset(imgProduct)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
                    title: boldText(
                        text: "${data["vendor_name"]}", color: fontGrey),
                    subtitle: normalText(
                        text: "${data["email"]}", color: fontGrey),
                  ),
                  Divider(),
                  10.heightBox,
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     children: List.generate(
                  //         profileButtonIcons.length,
                  //         (index) => ListTile(
                  //               onTap: () {
                  //                 switch (index) {
                  //                   case 0:
                  //                     Get.to(() => MessageScreen());
                  //                   case 1:
                  //                     Get.to(() => ReviewScreen());
                  //
                  //                     break;
                  //                   default:
                  //                 }
                  //               },
                  //               leading: Icon(
                  //                 profileButtonIcons[index],
                  //                 color: purpleColor,
                  //               ),
                  //               title: normalText(
                  //                   text: profileButtonTitles[index],
                  //                   color: fontGrey),
                  //             )),
                  //   ),
                  // )
                ],
              );
            })));
  }
}
