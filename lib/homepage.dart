import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'folder.dart/app_colors.dart';
import 'package:the_leaf_medic/cultivation_guide.dart';
import 'package:the_leaf_medic/disease_detection/detectpage.dart';
import 'package:the_leaf_medic/chatbot.dart';
import 'package:the_leaf_medic/folder.dart/app_drawer.dart';

void main() {
  runApp(GetMaterialApp(
    home: MainScreen(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        bool shouldExit = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Do you want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false;

        if (shouldExit) {
          // Use SystemNavigator.pop to gracefully close the app
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            'Crops Disease Detection',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: AppColors.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: [
            _buildBackground(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 18),
                    _buildMainContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: _buildChatBotFAB(),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }

  Widget _buildMainContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildIntroContainer(),
          SizedBox(height: 20),
          _buildFunctionContainer(),
          SizedBox(height: 20),
          _buildCaptureButton(),
        ],
      ),
    );
  }

  Widget _buildIntroContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Explore the realm of',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        Text(
          'The Leaf Medic!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletPoint(
              'Scan crop leaves',
              AppColors.mainColor,
              Colors.orangeAccent,
            ),
            _buildBulletPoint(
              'Detect and classify diseases',
              AppColors.mainColor,
              Colors.orangeAccent,
            ),
            _buildBulletPoint(
              'Recommend disease solutions',
              AppColors.mainColor,
              Colors.orangeAccent,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text, Color textColor, Color bulletColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: bulletColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/camera.png',
              width: 60,
              height: 60,
            ),
            Text(
              'Scan',
              style: TextStyle(color: AppColors.mainColor),
            ),
          ],
        ),
        Icon(
          Icons.arrow_right_alt_sharp,
          color: AppColors.mainColor,
          size: 50,
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/classify.png',
              width: 60,
              height: 60,
            ),
            Text(
              'Classify',
              style: TextStyle(color: AppColors.mainColor),
            ),
          ],
        ),
        Icon(
          Icons.arrow_right_alt_sharp,
          color: AppColors.mainColor,
          size: 50,
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/solution.png',
              width: 60,
              height: 60,
            ),
            Text(
              'Solve',
              style: TextStyle(color: AppColors.mainColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCaptureButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => DetectPage());
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.mainColor,
          shadowColor: AppColors.fifthcolor,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/magnify.png',
              width: 28,
              height: 38,
            ),
            SizedBox(width: 8),
            Text(
              'Detect Now',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBotFAB() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => ChatScreen());
      },
      backgroundColor: AppColors.mainColor,
      child: Icon(Icons.chat, color: Colors.white, size: 30),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => CropsPage());
          }
        },
        backgroundColor: Color.fromARGB(255, 21, 126, 26),
        selectedItemColor: Color.fromARGB(255, 58, 165, 31),
        unselectedItemColor: Colors.grey,
        iconSize: 25,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Crops Guide',
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Smart Grow',
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_2_outlined),
            label: 'Market',
          ),
        ],
      ),
    );
  }
}
