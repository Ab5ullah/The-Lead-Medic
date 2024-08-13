import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/auth_wrapper.dart';

import 'package:the_leaf_medic/getstarted.dart';
import 'package:the_leaf_medic/homepage.dart';
import 'package:the_leaf_medic/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:the_leaf_medic/onboarding.dart';
import 'package:the_leaf_medic/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermissions();

  runApp(MyApp());
}

Future<void> requestPermissions() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }

  var storageStatus = await Permission.storage.status;
  if (!storageStatus.isGranted) {
    await Permission.storage.request();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/getstarted', page: () => LeafMedicScreen()),
        GetPage(name: '/auth', page: () => AuthPage()),
        GetPage(name: '/login', page: () => LoginForm()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/forgotpassword', page: () => ForgotPasswordPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
      ],
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override

  // Delay navigation to ensure SplashScreen is disposed
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () async {
      // Check if the user has already seen the onboarding screens
      bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (isLoggedIn) {
        Get.offNamed('/home');
      } else {
        Get.offNamed('/getstarted');
      }
    });

    return PopScope(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "The Leaf Medic",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(176, 210, 106, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
