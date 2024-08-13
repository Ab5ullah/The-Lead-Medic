import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class pepperCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pakistani Pepper Culture',
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
                  'Pepper is an economically significant crop in many countries, including regions of Asia and South America. It is valued for its culinary uses and medicinal properties, contributing to local economies through export and domestic sales.',
            ),
            _buildCultureItem(
              icon: Icons.all_inclusive,
              title: 'Symbol of prosperity',
              content:
                  'Pepper is a symbol of culinary delight and diversity. It enhances the flavor of various dishes and cuisines worldwide, making it an essential ingredient in kitchens globally.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.celebration,
              title: 'Agricultural Festivals',
              content:
                  'Pepper harvest festivals are celebrated in some pepper-growing regions, marking the culmination of the harvest season. These festivals often include cultural events, music, and traditional dances.',
            ),

            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.palette,
              title: 'Art and Handicrafts',
              content:
                  'Pepper\'s cultural significance is reflected in various cuisines and culinary traditions worldwide. It has been used historically in traditional medicine and cultural practices, showcasing its enduring importance.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.music_note,
              title: 'Folk Songs',
              content:
                  'Pepper has a rich history and is often mentioned in folklore and ancient texts. Its journey from being a valuable commodity in ancient trade to a staple in modern cuisine highlights its enduring cultural relevance.',
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
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
