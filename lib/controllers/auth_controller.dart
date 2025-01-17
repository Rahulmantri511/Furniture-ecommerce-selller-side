import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  Stream<User?> get currentUserStream => auth.authStateChanges();


  //textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }



  //signout method

  signoutMethod(context) async {
    try{
      await auth.signOut();
    }catch (e){
      VxToast.show(context, msg: e.toString());
    }
  }



}