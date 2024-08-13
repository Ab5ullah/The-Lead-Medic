import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CottonTargetSpotPage extends StatefulWidget {
  @override
  _CottonTargetSpotPageState createState() => _CottonTargetSpotPageState();
}

class _CottonTargetSpotPageState extends State<CottonTargetSpotPage> {
  bool isTreatNowSelected = true;

  void _shareContent() {
    String content = "Disease Name: Cotton Target Spot\n\n";

    content +=
        "Cotton Target Spot is a fungal disease commonly affecting cotton plants. It is caused by the fungus Corynespora cassiicola. The disease is characterized by circular to angular spots with distinct concentric rings on the leaves, stems, and bolls. It can lead to premature defoliation and reduced cotton yield. Cotton Target Spot can survive on infected plant debris and spread through windblown spores and rain splashes. High humidity and warm temperatures promote its development.\n\n";

    content +=
        "> Symptoms:\n• Circular spots with concentric rings on leaves\n• Premature defoliation of infected leaves\n• Dark lesions on stems and bolls\n• Yellowing of the surrounding tissue\n\n";

    content +=
        "> More Info:\n• Scientific Name: Corynespora cassiicola\n• Also Found In: Other hosts include soybean, peanuts, and cucurbits.\n\n";

    content += "> Treat Now:\n";
    content +=
        "Recommendations:\nTo manage Cotton Target Spot effectively, implement the following measures. Regularly inspect cotton fields to detect and identify the disease at its early stages. Remove and destroy infected plant material to prevent further spread. Apply appropriate fungicides following recommended dosage and application timings. Practice crop rotation with non-host plants to break the disease cycle. Ensure proper field sanitation and avoid excessive plant density. Use disease-resistant cotton varieties whenever possible to reduce the risk of infection. Consult with local agricultural experts for region-specific recommendations.\n\n";

    content +=
        "> Pesticides: Here are the recommended pesticides to cure Cotton Target Spot:\n";
    content +=
        "• Triadimefon: Triadimefon-based fungicides provide effective control against Cotton Target Spot. Follow recommended application rates and safety precautions.\n\n";
    content +=
        "• Pyraclostrobin: Pyraclostrobin fungicides offer broad-spectrum disease control, including Cotton Target Spot. Use as directed on the product label.\n\n";
    content +=
        "• Azoxystrobin: Azoxystrobin-based fungicides can suppress the disease and improve cotton plant health. Adhere to proper application guidelines.\n\n";

    content += "> Prevent:\n";
    content +=
        "Preventive Measures:\nTo prevent Cotton Target Spot, consider the following measures:\n• Practice crop rotation with non-host crops.\n• Choose disease-resistant cotton varieties for cultivation.\n• Maintain proper plant spacing and avoid overcrowding.\n• Remove and destroy infected plant material promptly.\n• Ensure good air circulation in the field.\n• Use balanced fertilizers to enhance plant vigor.\n• Implement proper irrigation practices to avoid water stress.\n• Monitor weather conditions and disease prevalence regularly.\n\n";

    content +=
        "> Fertilizers:\nRecommended fertilizers for healthy cotton growth:\n";
    content +=
        "• Calcium Nitrate: Calcium Nitrate provides a source of calcium, promoting healthy cotton growth and development.\n";
    content +=
        "• Calcium Ammonium Nitrate: Calcium Ammonium Nitrate offers a balanced blend of calcium and nitrogen, supporting cotton plant health and yield.\n\n";

    content += "> What Caused It:\n";
    content +=
        "Cotton Target Spot is primarily caused by the fungus Corynespora cassiicola. The pathogen survives on infected plant debris and alternative hosts during winter and infects young cotton plants in the growing season. High humidity and moderate temperatures create a favorable environment for spore germination and disease spread. Implementing preventive measures and using resistant cotton varieties are essential to manage Cotton Target Spot effectively and protect cotton crops from significant yield losses.";

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
                      'Cotton Target Spot',
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
                    'assets/images/cotton/cottontargetspot1.jpg',
                    'assets/images/cotton/cottontargetspot2.jpg',
                    'assets/images/cotton/cottontargetspot3.jpg',
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
                    'Cotton Target Spot is a fungal disease commonly affecting cotton plants. It is caused by the fungus Corynespora cassiicola. The disease is characterized by circular to angular spots with distinct concentric rings on the leaves, stems, and bolls. It can lead to premature defoliation and reduced cotton yield. Cotton Target Spot can survive on infected plant debris and spread through windblown spores and rain splashes. High humidity and warm temperatures promote its development.',
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
                              'Circular spots with concentric rings on leaves'),
                          _buildBulletDot(
                              'Premature defoliation of infected leaves'),
                          _buildBulletDot('Dark lesions on stems and bolls'),
                          _buildBulletDot(
                              'Yellowing of the surrounding tissue'),
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
                              text: 'Corynespora cassiicola',
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
                        '• Also Found In: Soybean, Peanuts, Cucurbits',
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
                          'To manage Cotton Target Spot effectively, implement the following measures. Regularly inspect cotton fields to detect and identify the disease at its early stages. Remove and destroy infected plant material to prevent further spread. Apply appropriate fungicides following recommended dosage and application timings. Practice crop rotation with non-host plants to break the disease cycle. Ensure proper field sanitation and avoid excessive plant density. Use disease-resistant cotton varieties whenever possible to reduce the risk of infection. Consult with local agricultural experts for region-specific recommendations.',
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
                          'Here are some recommended pesticides to cure Cotton Target Spot :',
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
                                    text: ' Triadimefon',
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
                              'Triadimefon-based fungicides provide effective control against Cotton Target Spot. Follow recommended application rates and safety precautions.',
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
                                    text: ' Pyraclostrobin',
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
                              'Pyraclostrobin fungicides offer broad-spectrum disease control, including Cotton Target Spot. Use as directed on the product label.',
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
                                    text: 'Azoxystrobin',
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
                              'Dinotefuran is a fast-acting insecticide that targets aphids nervous system, leading to rapid elimination of aphids. It provides effective control and is commonly used in integrated pest management programs',
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
                          'To prevent Cotton Target Spot disease, consider the following measures:',
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                        SizedBox(height: 12),

                        // Customized Bulleted List of Preventive Measures
                        ListBody(
                          children: [
                            _buildBulletDot(
                                'Practice crop rotation with non-host crops.'),
                            _buildBulletDot(
                                'Use disease-resistant cotton varieties.'),
                            _buildBulletDot(
                                'Maintain good plant spacing and avoid overcrowding.'),
                            _buildBulletDot(
                                'Keep the field free from plant debris and weeds.'),
                            _buildBulletDot(
                                'Apply balanced fertilizers to enhance plant vigor.'),
                            _buildBulletDot(
                                'Use drip irrigation to minimize leaf wetness.'),
                            _buildBulletDot(
                                'Monitor and manage insect pests to reduce plant stress.'),
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
                          'Here are some recommended fertilizers for healthy Cotton growth:',
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
                                    text: 'Calcium Nitrate',
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
                              'Calcium Nitrate provides a source of calcium and nitrogen, promoting healthy cotton growth and development.',
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
                                    text: 'Calcium Ammonium Nitrate',
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
                              'Calcium Ammonium Nitrate offers a balanced blend of calcium and nitrogen, supporting cotton plant health and yield.',
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
                        'Cotton Target Spot is primarily caused by the fungus Corynespora cassiicola. The pathogen can survive on infected plant debris and alternate hosts. Warm and humid environmental conditions favor disease development. Spores are dispersed through wind and rain, leading to infection on cotton plants. Implementing preventive measures and using resistant varieties can mitigate the impact of Cotton Target Spot and protect cotton yields. Regular monitoring and timely fungicide applications can aid in disease management.',
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
