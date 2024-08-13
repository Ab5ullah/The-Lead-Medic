import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class WheatCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pakistani Wheat Culture',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.0, left: 16, right: 16, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(16.0), // Add rounded corners
                child: Image.asset(
                  'assets/images/culture.png',
                  width: 400,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius:
                    BorderRadius.circular(16.0), // Add rounded corners
              ),
            ),
            _buildCultureItem(
              icon: Icons.bar_chart,
              title: 'Economic Importance',
              content:
                  'Wheat holds significant economic importance in Pakistan. It is a major agricultural crop that contributes to the country\'s GDP and provides employment to many people. As a staple food, wheat plays a crucial role in ensuring food security and stability. Additionally, Pakistan exports surplus wheat, contributing to foreign exchange earnings.',
            ),
            _buildCultureItem(
              icon: Icons.all_inclusive,
              title: 'Cultural Identity',
              content:
                  'Wheat is deeply woven into the cultural identity of Pakistan. As a staple food, it forms an integral part of the nation\'s food culture and is considered a symbol of sustenance and nourishment.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.celebration,
              title: 'Cermonies and Festivals',
              content:
                  'Wheat is often used in various events and ceremonies in Pakistan. In some regions, wheat grains may be offered during weddings or religious events as a symbol of blessings, prosperity, and good fortune for the couple or the community.',
            ),

            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.palette,
              title: 'Art and Handicrafts',
              content:
                  'Wheat motifs can be found in Pakistani art and craftsmanship. Traditional designs featuring wheat stalks are often depicted in textiles, pottery, and other forms of decorative art, representing the cultural importance of wheat and its connection to the agrarian lifestyle.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.music_note,
              title: 'Folklore and Folk Songs',
              content:
                  'Wheat is a popular theme in Pakistani folklore and folk songs. Traditional tales and songs often revolve around the significance of wheat in rural life, depicting the agricultural practices, harvesting rituals, and the vital role wheat plays in sustaining livelihoods.',
            ),
            // Add more cultural information about corn here
          ],
        ),
      ),
    );
  }

  Widget _buildCultureItem(
      {required IconData icon,
      required String title,
      required String content}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.9),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0), // Add horizontal margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 30, color: AppColors.mainColor),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            content,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
