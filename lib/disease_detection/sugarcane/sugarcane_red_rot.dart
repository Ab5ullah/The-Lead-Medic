import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SugarcaneRedRotPage extends StatefulWidget {
  @override
  _SugarcaneRedRotPageState createState() => _SugarcaneRedRotPageState();
}

class _SugarcaneRedRotPageState extends State<SugarcaneRedRotPage> {
  bool isTreatNowSelected = true;
  void _shareContent() {
    String content = "Disease Name: Sugarcane Red Rot\n\n";

    content +=
        "Sugarcane Red Rot is a devastating fungal disease that affects sugarcane crops. It is caused by the pathogen Colletotrichum falcatum. The disease leads to significant losses in sugarcane yield and quality, making it a major concern for sugarcane farmers worldwide. The fungus infects the stalks of the sugarcane plant, resulting in red discoloration and rotting of the affected tissues. Red Rot spreads rapidly, particularly under warm and humid conditions, posing a serious threat to sugarcane production.\n";

    content +=
        "> Symptoms:\n• Red discoloration and decay of sugarcane stalks\n";
    content += "• Presence of elongated lesions on the internodes\n";
    content += "• Premature wilting and drying of leaves\n";
    content += "• Exudation of reddish-brown ooze from infected areas\n\n";

    content += "> More Info:\n• Scientific Name: Colletotrichum falcatum\n";
    content +=
        "• Also Found In: Other grasses and plants belonging to the Poaceae family.\n\n";

    content += "> Treat Now:\n";
    content +=
        "Recommendations:\nTo manage Sugarcane Red Rot effectively, farmers should adopt integrated disease management strategies. These may include selecting disease-resistant sugarcane varieties, practicing proper crop sanitation, and removing and destroying infected plant material. Regular scouting for symptoms and timely application of suitable fungicides can help control the disease's spread. Additionally, maintaining adequate soil nutrition and water management is crucial to minimize the disease's impact.\n\n";

    content +=
        "> Pesticides: Here are the recommended pesticides to cure Sugarcane Red Rot:\n";
    content +=
        "• Tebuconazole: Tebuconazole-based fungicides are effective in controlling Sugarcane Red Rot. The fungicide inhibits the fungus's growth and helps prevent further spread of the disease.\n";
    content +=
        "• Propiconazole: Propiconazole is another recommended fungicide that provides effective control over Colletotrichum falcatum. It offers protective and curative action against the pathogen.\n";
    content +=
        "• Thiophanate-methyl: Thiophanate-methyl fungicides are widely used to manage fungal diseases, including Sugarcane Red Rot. They protect sugarcane plants from infection and reduce disease severity.\n\n";

    content += "> Prevent:\n";
    content +=
        "Preventive Measures:\nTo prevent Sugarcane Red Rot, consider the following measures:\n";
    content += "• Plant disease-free and certified sugarcane seedlings.\n";
    content += "• Practice crop rotation to break the disease cycle.\n";
    content += "• Avoid waterlogging and ensure proper drainage.\n";
    content +=
        "• Implement suitable weed control measures to reduce disease reservoirs.\n";
    content +=
        "• Adopt balanced fertilization practices to enhance plant resistance.\n";
    content +=
        "• Remove and burn infected crop debris to prevent disease carryover.\n";
    content +=
        "• Apply biological control agents or biopesticides to suppress the pathogen.\n";
    content +=
        "• Monitor the field regularly for early detection of symptoms.\n";
    content +=
        "• Train farmers on disease identification and management practices.\n\n";

    content +=
        "> Fertilizers: Recommended fertilizers for healthy sugarcane growth:\n";
    content +=
        "• Triple Superphosphate: Triple Superphosphate is a phosphorus-rich fertilizer that promotes root development and overall plant health. Adequate phosphorus enhances sugarcane's resistance to various diseases, including Red Rot.\n";
    content +=
        "• Monoammonium Phosphate: Monoammonium Phosphate provides a balanced supply of nitrogen and phosphorus, crucial for sugarcane growth. Nitrogen strengthens plant immunity, while phosphorus contributes to energy transfer and disease tolerance.\n\n";

    content += "> What Caused It:\n";
    content +=
        "Sugarcane Red Rot is primarily caused by the pathogenic fungus Colletotrichum falcatum. The fungus survives in infected sugarcane debris and can persist in the soil for extended periods. Warm and humid conditions favor the pathogen's germination and penetration into sugarcane tissues. Once inside the plant, the fungus spreads rapidly, leading to red discoloration and rotting of the stalks. Over time, the disease weakens the sugarcane plants, resulting in wilting and reduced yield. Implementing effective preventive measures and utilizing disease-resistant varieties are essential to manage Sugarcane Red Rot and sustain healthy sugarcane crops.\n";

    // Use the share plugin to share the content
    Share.share(content);
  }

  Widget _buildBulletDot(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3, // Adjust the size of the bullet dot
            height: 3,
            margin: EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black, // Customize the color of the bullet dot
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 15, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 74, 181, 58),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Sugarcane Red Rot',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Fungus',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 74, 181, 58),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.27,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.95,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: [
                    'assets/images/sugarcane/sugarcaneredrot1.jpg',
                    'assets/images/sugarcane/sugarcaneredrot2.jpg',
                    'assets/images/sugarcane/sugarcaneredrot3.jpg',
                  ].map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Color.fromARGB(153, 226, 226, 226),
                  thickness: 1,
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color.fromARGB(255, 74, 181, 58),
                        size: 22,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'About Disease',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(7, 0, 10, 0),
                  child: Text(
                    'Sugarcane Red Rot is a devastating fungal disease that affects sugarcane crops. It is caused by the pathogen Colletotrichum falcatum. The disease leads to significant losses in sugarcane yield and quality, making it a major concern for sugarcane farmers worldwide. The fungus infects the stalks of the sugarcane plant, resulting in red discoloration and rotting of the affected tissues. Red Rot spreads rapidly, particularly under warm and humid conditions, posing a serious threat to sugarcane production.',
                    style: TextStyle(fontSize: 17, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 15),
                Divider(
                  color: Color.fromARGB(153, 226, 226, 226),
                  thickness: 1,
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.local_florist,
                        color: Color.fromARGB(255, 74, 181, 58),
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Symptoms',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customized Bulleted List of Symptoms with custom padding
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          7, 0, 0, 5), // Add your desired padding value here
                      child: ListBody(
                        children: [
                          _buildBulletDot(
                              'Red discoloration and decay of sugarcane stalks'),
                          _buildBulletDot(
                              'Presence of elongated lesions on the internodes'),
                          _buildBulletDot(
                              'Premature wilting and drying of leaves'),
                          _buildBulletDot(
                              'Exudation of reddish-brown ooze from infected areas'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color.fromARGB(153, 226, 226, 226),
                  thickness: 1,
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        // Icons.arrow_forward,
                        Icons.description,
                        color: Color.fromARGB(255, 74, 181, 58),
                        size: 21,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'More Info',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '• Scientific Name: ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Xanthomonas albilineans',
                              style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Also Found In: Poaceae rasses and Plants ',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Divider(
                  color: Color.fromARGB(153, 226, 226, 226),
                  thickness: 1,
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTreatNowSelected = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(right: 0),
                          decoration: BoxDecoration(
                            color: isTreatNowSelected
                                ? Colors.black
                                : Color.fromARGB(153, 226, 226, 226),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Treat Now',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: isTreatNowSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isTreatNowSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: !isTreatNowSelected
                                ? Colors.black
                                : Color.fromARGB(153, 226, 226, 226),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Prevent',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: !isTreatNowSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Visibility(
                  visible: isTreatNowSelected,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommendations',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'To manage Sugarcane Red Rot effectively, farmers should adopt integrated disease management strategies. These may include selecting disease-resistant sugarcane varieties, practicing proper crop sanitation, and removing and destroying infected plant material. Regular scouting for symptoms and timely application of suitable fungicides can help control the disease,s spread. Additionally, maintaining adequate soil nutrition and water management is crucial to minimize the disease,s impact.',
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: Color.fromARGB(153, 226, 226, 226),
                          thickness: 1,
                          height: 30,
                        ),
                        SizedBox(height: 05),
                        Row(
                          children: [
                            Icon(
                              Icons.eco,
                              color: Color.fromARGB(255, 74, 181, 58),
                              size: 22,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Pesticides',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Here are some recommended pesticides to cure Sugarcane Red Rot:',
                          style: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '• ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Tebuconazole',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Tebuconazole-based fungicides are effective in controlling Sugarcane Red Rot. The fungicide inhibits the fungus,s growth and helps prevent further spread of the disease.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                text: '• ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Propiconazole',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Propiconazole is another recommended fungicide that provides effective control over Colletotrichum falcatum. It offers protective and curative action against the pathogen.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                text: '• ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Thiophanate-methyl',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Another antibiotic effective against bacterial pathogens in sugarcane. Proper application following guidelines is essential for maximum efficacy.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !isTreatNowSelected,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 7, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preventive Measures',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'To prevent Sugarcane Red Rot disease, consider the following measures:',
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                        SizedBox(height: 12),

                        // Customized Bulleted List of Preventive Measures
                        ListBody(
                          children: [
                            _buildBulletDot(
                                'Plant disease-free and certified sugarcane seedlings.'),
                            _buildBulletDot(
                                'Practice crop rotation to break the disease cycle.'),
                            _buildBulletDot(
                                'Avoid waterlogging and ensure proper drainage.'),
                            _buildBulletDot(
                                'Implement suitable weed control measures to reduce disease reservoirs.'),
                            _buildBulletDot(
                                'Adopt balanced fertilization practices to enhance plant resistance.'),
                            _buildBulletDot(
                                'Remove and burn infected crop debris to prevent disease carryover.'),
                            _buildBulletDot(
                                'Apply biological control agents or biopesticides to suppress the pathogen.'),
                            _buildBulletDot(
                                'Monitor the field regularly for early detection of symptoms.'),
                            _buildBulletDot(
                                'Train farmers on disease identification and management practices.'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: Color.fromARGB(153, 226, 226, 226),
                          thickness: 1,
                          height: 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.eco_outlined,
                              color: Color.fromARGB(255, 74, 181, 58),
                              size: 22,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Fertlizers',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Here are some recommended fertilizers for healthy Sugarcane growth:',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '• ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Triple Superphosphate',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Triple Superphosphate is a phosphorus-rich fertilizer that promotes root development and overall plant health. Adequate phosphorus enhances sugarcane,s resistance to various diseases, including Red Rot.',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                text: '• ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Monoammonium Phosphate',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Monoammonium Phosphate provides a balanced supply of nitrogen and phosphorus, crucial for sugarcane growth. Nitrogen strengthens plant immunity, while phosphorus contributes to energy transfer and disease tolerance',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color.fromARGB(153, 226, 226, 226),
                  thickness: 1,
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'What Caused It?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Sugarcane Red Rot is primarily caused by the pathogenic fungus Colletotrichum falcatum. The fungus survives in infected sugarcane debris and can persist in the soil for extended periods. Warm and humid conditions favor the pathogen,s germination and penetration into sugarcane tissues. Once inside the plant, the fungus spreads rapidly, leading to red discoloration and rotting of the stalks. Over time, the disease weakens the sugarcane plants, resulting in wilting and reduced yield. Implementing effective preventive measures and utilizing disease-resistant varieties are essential to manage Sugarcane Red Rot and sustain healthy sugarcane crops.',
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Color.fromARGB(153, 226, 226, 226),
                        thickness: 1,
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Get In Touch',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),

                      // Social Media Icons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // WhatsApp Icon
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://www.instagram.com/theleafmedic/');

                              // Add the link to your WhatsApp account
                              // when the icon is tapped.
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Image.asset(
                                'assets/images/instagram.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),

                          // Facebook Icon
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'https://www.facebook.com/theleafmedic/');
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Image.asset(
                                'assets/images/facebook.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),

                          // Instagram Icon

                          // Email Icon
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  'mailto:theleafmedic.official@gmail.com');

                              // Add the link to your Email account
                              // when the icon is tapped.
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Image.asset(
                                'assets/images/email.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shareContent,
        child: Icon(
          Icons.share_rounded,
        ),
        backgroundColor: Color.fromARGB(255, 74, 181, 58),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
    // );
  }

  void _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
