import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_drawer.dart';
import 'package:the_leaf_medic/cultivation/corn/corn_cultivation.dart';
import 'package:the_leaf_medic/cultivation/cotton/cotton_cultivation.dart';
import 'package:the_leaf_medic/cultivation/rice/rice_cultivation.dart';
import 'package:the_leaf_medic/cultivation/sugarcane//sugarcane_cultivation.dart';
import 'package:the_leaf_medic/cultivation/wheat/wheat_cultivation.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:the_leaf_medic/cultivation/apple/apple_cultivation.dart';
import 'package:the_leaf_medic/cultivation/cherry/cherry_cultivation.dart';
import 'package:the_leaf_medic/cultivation/grape/grape_cultivation.dart';
import 'package:the_leaf_medic/cultivation/orange/orange_cultivation.dart';
import 'package:the_leaf_medic/cultivation/pepper/pepper_cultivation.dart';
import 'package:the_leaf_medic/cultivation/potato/potato_cultivation.dart';
import 'package:the_leaf_medic/cultivation/tomato/tomato_cultivation.dart';

class CropsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Cultivation Guide',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, AppColors.mainColor],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            CropItem(
              name: 'Corn',
              imagePath: 'assets/images/corn/corn_leaf.png',
              scientificName: 'Zea mays',
            ),
            CropItem(
              name: 'Cotton',
              imagePath: 'assets/images/cotton/cotton_leaf.png',
              scientificName: 'Gossypium',
            ),
            CropItem(
              name: 'Rice',
              imagePath: 'assets/images/rice/rice_leaf.png',
              scientificName: 'Oryza sativa',
            ),
            CropItem(
              name: 'Sugarcane',
              imagePath: 'assets/images/sugarcane/sugarcane_leaf.png',
              scientificName: 'Saccharum officinarum',
            ),
            CropItem(
              name: 'Wheat',
              imagePath: 'assets/images/wheat/wheat_leaf1.png',
              scientificName: 'Triticum',
            ),
            CropItem(
              name: 'Apple',
              imagePath: 'assets/images/apple/apple_leaf.png',
              scientificName: 'Malus',
            ),
            CropItem(
              name: 'Cherry',
              imagePath: 'assets/images/cherry/cherry_leaf.png',
              scientificName: 'Prunus avium',
            ),
            CropItem(
              name: 'Grape',
              imagePath: 'assets/images/grape/grape_leaf.png',
              scientificName: 'Vitis vinifera',
            ),
            CropItem(
              name: 'Orange',
              imagePath: 'assets/images/orange/orange_leaf.png',
              scientificName: 'Citrus sinensis',
            ),
            CropItem(
              name: 'Pepper',
              imagePath: 'assets/images/pepper/pepper_leaf.png',
              scientificName: 'Capsicum annuum',
            ),
            CropItem(
              name: 'Potato',
              imagePath: 'assets/images/potato/potato_leaf.png',
              scientificName: 'Solanum tuberosum',
            ),
            CropItem(
              name: 'Tomato',
              imagePath: 'assets/images/tomato/tomato_leaf.png',
              scientificName: 'Solanum',
            ),
          ],
        ),
      ),
    );
  }
}

class CropItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final String scientificName;

  const CropItem({
    required this.name,
    required this.imagePath,
    required this.scientificName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (name) {
          case 'Corn':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CornDetailPage(),
              ),
            );
            break;
          case 'Cotton':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CottonDetailPage(),
              ),
            );
            break;
          case 'Rice':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RiceDetailPage(),
              ),
            );
            break;
          case 'Sugarcane':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SugarcaneDetailPage(),
              ),
            );
            break;
          case 'Wheat':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WheatDetailPage(),
              ),
            );
            break;
          case 'Apple':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppleDetailPage(),
              ),
            );
            break;
          case 'Cherry':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CherryDetailPage(),
              ),
            );
            break;
          case 'Grape':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GrapeDetailPage(),
              ),
            );
            break;
          case 'Orange':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrangeDetailPage(),
              ),
            );
            break;
          case 'Pepper':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pepperDetailPage(),
              ),
            );
            break;
          case 'Potato':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PotatoDetailPage(),
              ),
            );
            break;
          case 'Tomato':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TomatoDetailPage(),
              ),
            );
            break;
        }
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Scientific Name: $scientificName',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mainColor,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
