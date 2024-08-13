import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:the_leaf_medic/folder.dart/app_drawer.dart';

import 'corn/corn.dart';
import 'cotton/cotton.dart';
import 'rice/rice.dart';
import 'sugarcane/sugarcane.dart';
import 'wheat/wheat.dart';
import 'apple/apple.dart';
import 'cherry/cherry.dart';
import 'pepper/pepper.dart';
import 'potato/potato.dart';
import 'tomato/tomato.dart';
import 'orange/orange.dart';
import 'grape/grape.dart';

class DetectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Avaliable Crops',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: AppColors.mainColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Center(
                    child: Text(
                      'Please select the Crop you want to detect.',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildCropItem(
                            'Corn',
                            'assets/images/corn/corn.png',
                            CornPage(),
                            context,
                          ),
                          _buildCropItem(
                            'Cotton',
                            'assets/images/cotton/cotton.png',
                            CottonPage(),
                            context,
                          ),
                          _buildCropItem(
                            'Rice',
                            'assets/images/rice/rice.png',
                            RicePage(),
                            context,
                          ),
                          _buildCropItem(
                            'Sugarcane',
                            'assets/images/sugarcane/sugarcane.png',
                            SugarcanePage(),
                            context,
                          ),
                          _buildCropItem(
                            'Wheat',
                            'assets/images/wheat/wheat.png',
                            WheatPage(),
                            context,
                          ),
                          _buildCropItem(
                            'Apple',
                            'assets/images/apple/apple.png',
                            ApplePage(),
                            context,
                          ),
                          _buildCropItem(
                            'Cherry',
                            'assets/images/cherry/cherry.png',
                            CherryPage(),
                            context,
                          ),
                          _buildCropItem(
                            'Grape',
                            'assets/images/grape/grape.png',
                            GrapePage(),
                            context,
                          ),
                          _buildCropItem(
                            'Orange',
                            'assets/images/orange/orange.png',
                            OrangePage(),
                            context,
                          ),
                          _buildCropItem(
                            'Pepper',
                            'assets/images/pepper/pepper.png',
                            PepperPage(),
                            context,
                          ),
                          _buildCropItem(
                            'Potato',
                            'assets/images/potato/potato.png',
                            PotatoPage(),
                            context,
                          ),
                          _buildCropItem(
                            'Tomato',
                            'assets/images/tomato/tomato.png',
                            TomatoPage(),
                            context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.mainColor],
        ),
      ),
    );
  }

  Widget _buildCropItem(
    String name,
    String imagePath,
    Widget nextPage,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80.0,
              height: 80.0,
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
