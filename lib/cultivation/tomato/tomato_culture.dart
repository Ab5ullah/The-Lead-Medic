import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class TomatoCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pakistani Tomato Culture',
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
                  'Tomatoes are economically significant in many countries, contributing to both local agricultural economies and global markets. They are widely cultivated for fresh consumption, processing into sauces and pastes, and as a key ingredient in various cuisines.',
            ),
            _buildCultureItem(
              icon: Icons.all_inclusive,
              title: 'Symbol of prosperity',
              content:
                  'Tomatoes symbolize prosperity in several cultures and culinary traditions. They are often associated with abundance and good fortune, used in festivals, rituals, and celebrations to signify growth, health, and prosperity.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.celebration,
              title: 'Agricultural Festivals',
              content:
                  'Tomato festivals are celebrated in various parts of the world, especially in regions renowned for tomato cultivation. These festivals showcase different tomato varieties, culinary uses, and cultural significance through cooking competitions, tastings, and parades.',
            ),

            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.palette,
              title: 'Art and Handicrafts',
              content:
                  'Tomatoes inspire art and cuisine globally, influencing traditional dishes, paintings, and culinary arts. From Italian pasta sauces to Mexican salsas, tomatoes are integral to diverse cuisines, reflecting cultural diversity and culinary creativity.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.music_note,
              title: 'Folk Songs',
              content:
                  'Tomatoes have cultural references in folk songs, stories, and literature across different regions. They symbolize vitality, culinary heritage, and agricultural prosperity in narratives and songs that celebrate farming traditions and harvest seasons.',
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
