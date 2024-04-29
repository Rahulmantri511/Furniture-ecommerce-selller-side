import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:furniture_seller_side/const/const.dart';
import 'package:furniture_seller_side/views/auth_screen/login_screen.dart';
import 'package:furniture_seller_side/views/home_screen/home.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD_70eItmlikQELBMAABNZk67VYkeKURY4",
        appId: "1:461249743712:android:fc6eee947baa09a87dac05",
        messagingSenderId: "461249743712",
        storageBucket: 'furniture-oko.appspot.com',
        projectId: "furniture-oko",
        // storageBucket: "furniture-oko.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }
  var isLoggedin = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if(user == null && mounted){
        isLoggedin = false;
      }else{
        isLoggedin = true;
      }
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      home: isLoggedin ? Home() : LoginScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // iconTheme: IconThemeData(color: Colors.white),
          //  backgroundColor: Colors.transparent,
          elevation: 0.0,
        )
      ),

    );
  }
}
