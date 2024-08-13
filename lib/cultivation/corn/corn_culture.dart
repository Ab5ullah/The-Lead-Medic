import 'package:flutter/material.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CornCulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Pakistani Corn Culture',
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
              icon: Icons.restaurant_menu,
              title: 'Traditional Staple Food',
              content:
                  'Corn holds a significant place in Pakistani cuisine and culture. It is a traditional staple food that is consumed in various forms, such as cornbread, cornmeal porridge, and roasted corn on the cob. The aroma of freshly roasted corn is a common sight during local festivals and street fairs.',
            ),
            _buildCultureItem(
              icon: Icons.all_inclusive,
              title: 'Symbolism & Mythology',
              content:
                  'Corn carries symbolic importance in several cultures. It is often associated with fertility, abundance, and sustenance, making it a symbol of prosperity and life.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.celebration,
              title: 'Festive Celebrations',
              content:
                  'Corn is an integral part of festive celebrations in Pakistan. During harvest festivals like "Makar Sankranti" or "Mela Chiraghan," corn is offered to family and friends as a symbol of prosperity and abundance. People come together to share corn-based dishes, enhancing the sense of community and joy.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.people_alt,
              title: 'Rituals and Ceremonies',
              content:
                  'In rural areas, corn plays a significant role in various rituals and ceremonies. During weddings and religious festivals, corn is used as an offering to invoke blessings and good fortune. It is also common to find corn being used in traditional healing practices and cultural rituals.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.palette,
              title: 'Art and Craftsmanship',
              content:
                  'Corn motifs can be found in Pakistani art and craftsmanship, adorning textiles, pottery, and intricate woodwork. The corn\'s representation in traditional art showcases its cultural importance and connection to the local identity.',
            ),
            SizedBox(height: 10.0),
            _buildCultureItem(
              icon: Icons.music_note,
              title: 'Folklore and Folk Songs',
              content:
                  'Corn is a popular theme in Pakistani folklore and folk songs. Traditional folktales often narrate stories that revolve around the significance of corn in rural life. Folk songs, sung during agricultural activities, celebrate the harvest and the significance of corn in sustaining livelihoods.',
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
