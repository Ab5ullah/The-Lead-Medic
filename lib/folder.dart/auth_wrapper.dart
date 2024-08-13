import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_leaf_medic/getstarted.dart';
import 'package:the_leaf_medic/homepage.dart';
import 'package:the_leaf_medic/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginForm();
          }
        },
      ),
    );
  }
}

//class AuthStateWrapper extends GetxController {
//  static AuthStateWrapper instance = Get.find();
//
//  late Rx<User?> _user;
//  FirebaseAuth auth = FirebaseAuth.instance;
//
//  @override
//  void onReady() {
//    super.onReady();
//    _user = Rx<User?>(auth.currentUser);
//    _user.bindStream(auth.userChanges());
//    ever(_user, _initialScreen);
//  }
//
//  void _initialScreen(User? user) {
//    if (user == null) {
//      Get.offAll(() => LeafMedicScreen()); // Navigate to getstarted
//    } else {
//      Get.offAll(() => HomePage());
//    }
//  }
//
//  Future<void> reset(BuildContext context, String email) async {
//    try {
//      await auth.sendPasswordResetEmail(email: email);
//      showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            content: Text('Password Reset link sent! Check your Email'),
//          );
//        },
//      );
//    } catch (e) {
//      Get.snackbar("About Password", "Reset message",
//          backgroundColor: Colors.redAccent,
//          snackPosition: SnackPosition.BOTTOM,
//          titleText: const Text("Email not found"),
//          messageText: Text(
//            e.toString(),
//            style: TextStyle(color: Colors.white),
//          ));
//    }
//  }
//
//  void register(String email, String password) async {
//    try {
//      await auth.createUserWithEmailAndPassword(
//          email: email, password: password);
//    } catch (e) {
//      Get.snackbar("About User", "User message",
//          backgroundColor: Colors.redAccent,
//          snackPosition: SnackPosition.BOTTOM,
//          titleText: const Text("Account Creation Failed"),
//          messageText: Text(
//            e.toString(),
//            style: TextStyle(color: Colors.white),
//          ));
//    }
//  }
//
//  void login(String email, String password) async {
//    try {
//      await auth.signInWithEmailAndPassword(email: email, password: password);
//    } catch (e) {
//      Get.snackbar("About login", "login message",
//          backgroundColor: Colors.redAccent,
//          snackPosition: SnackPosition.BOTTOM,
//          titleText: const Text("Signin Failed"),
//          messageText: Text(
//            e.toString(),
//            style: const TextStyle(color: Colors.white),
//          ));
//    }
//  }
//
//  void logout() async {
//    await auth.signOut();
//  }
//}
//
//Future<UserCredential?> signInWithGoogle() async {
//  try {
//    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//
//    if (googleSignInAccount != null) {
//      final GoogleSignInAuthentication googleSignInAuthentication =
//          await googleSignInAccount.authentication;
//
//      final AuthCredential credential = GoogleAuthProvider.credential(
//        accessToken: googleSignInAuthentication.accessToken,
//        idToken: googleSignInAuthentication.idToken,
//      );
//
//      return await _auth.signInWithCredential(credential);
//    }
//  } catch (error) {
//    print("Google Sign-In Error: $error");
//  }
//}
