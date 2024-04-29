import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_seller_side/views/widgets/applogo_widget.dart';
import 'package:furniture_seller_side/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../const/const.dart';
import '../auth_screen/login_screen.dart';
import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds:5),(){
      //using getX
      // Get.to(()=>const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(()=> const LoginScreen());
        }else{
          Get.to(()=> const Home());
        }
      });
    });
  }
  @override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3E8E1),
      body: Center(
        child: Column(
          children: [
            150.heightBox,
            applogoWidget(),
            20.heightBox,
            boldText(text: appname,size: 22.0,color: purpleColor),
            50.heightBox,

            Lottie.asset("assets/animations/splash screen.json"),


          ],
        ),
      ),
    );
  }
}
