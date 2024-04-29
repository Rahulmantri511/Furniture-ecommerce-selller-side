import 'package:furniture_seller_side/controllers/auth_controller.dart';
import 'package:furniture_seller_side/views/home_screen/home.dart';
import 'package:furniture_seller_side/views/widgets/bg_widget.dart';
import 'package:furniture_seller_side/views/widgets/loading_indicator.dart';
import 'package:furniture_seller_side/views/widgets/our_button.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Column(
                children: [
                  Image.asset(iclogo, width: 80, height: 80)
                      .box
                      .border(color: white)
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .makeCentered(),
                  10.heightBox,
                  Center(child: boldText(text: appname, size: 20.0)),
                ],
              ),
              40.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: normalText(text: loginTo, size: 18.0, color: purpleColor)),
              ),
              10.heightBox,
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: boldText(text: "Email", color: purpleColor),
                    ),
                    10.heightBox,
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: emailHint),
                    ),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: boldText(text: "Password", color: purpleColor),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: textfieldGrey,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: passwordHint),
                    ),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: normalText(
                                text: forgotPassword, color: purpleColor))),
                    30.heightBox,
                    Center(
                      child: SizedBox(
                        width: context.screenWidth - 60,
                        child: controller.isloading.value
                            ? loadingIndicator()
                            : ourButton(
                                title: login,
                                onPress: () async {
                                  controller.isloading(true);

                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedin);
                                      controller.isloading(false);
                                      Get.offAll(() => Home());
                                    } else {
                                      controller.isloading(false);
                                    }
                                  });
                                }),
                      ),
                    )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadow.shadowMd
                    .padding(EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: fontGrey)),
            ],
          ),
        ),
      ),
    ));
  }
}
