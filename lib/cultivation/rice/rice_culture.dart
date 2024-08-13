import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class RiceCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pakistani Rice Culture',
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
                  'Rice is a major agricultural crop in Pakistan and contributes significantly to the country\'s economy. It is grown in various regions, and its export is an essential source of foreign exchange, making it a crucial component of Pakistan\'s agricultural sector.',
            ),
            _buildCultureItem(
              icon: Icons.all_inclusive,
              title: 'Cultural Identity',
              content:
                  'Rice is deeply embedded in the cultural identity of Pakistan. It is not only a staple food but also an integral part of traditional ceremonies and social gatherings, enhancing the sense of community and shared heritage among the people.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.celebration,
              title: 'Agricultural Festivals',
              content:
                  ' Rice plays a central role in various festive celebrations in Pakistan. During religious holidays and special occasions, rice dishes like biryani are prepared and shared with family and friends. The act of sharing rice-based dishes symbolizes unity, generosity, and abundance.',
            ),

            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.palette,
              title: 'Art and Handicrafts',
              content:
                  'Rice motifs can be found in Pakistani art and craftsmanship. Traditional designs featuring rice grains are often intricately woven into textiles, pottery, and decorative items, reflecting the cultural importance of rice in the local identity.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.music_note,
              title: 'Folk Songs',
              content:
                  'Rice is a popular theme in Pakistani folklore and folk songs. Traditional tales and songs often depict the significance of rice in sustaining livelihoods and its role as a symbol of sustenance and prosperity in rural life.',
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
