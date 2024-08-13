import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CottonCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pakistani Cotton Culture',
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
                  'Cotton is one of the most important cash crops in Pakistan. The country is known for producing high-quality cotton, which is a major contributor to its textile industry. The cotton sector plays a vital role in the national economy, providing employment and income to millions of people.',
            ),
            _buildCultureItem(
              icon: Icons.all_inclusive,
              title: 'Symbol of prosperity',
              content:
                  'Cotton, as a symbol of prosperity, is sometimes used in religious and cultural ceremonies. In certain rituals, cotton may be offered as a symbol of abundance and good fortune.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.celebration,
              title: 'Agricultural Festivals',
              content:
                  'Cotton harvest festivals are celebrated in various regions of Pakistan. These festivals mark the culmination of the cotton harvesting season and are occasions of joy and gratitude among farming communities. Traditional dances, music, and cultural activities are often part of these celebrations.',
            ),

            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.palette,
              title: 'Art and Handicrafts',
              content:
                  'Cotton\'s significance is also reflected in Pakistani art and handicrafts. Textiles made from cotton, such as colorful clothing and intricate embroidery, showcase the cultural richness and craftsmanship of the region.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.music_note,
              title: 'Folk Songs',
              content:
                  'Cotton finds its place in Pakistani folklore and folk songs as well. Traditional tales may highlight the importance of cotton in the lives of rural communities, and folk songs sung during agricultural activities may celebrate the cotton harvest and its role in sustaining communities.',
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
