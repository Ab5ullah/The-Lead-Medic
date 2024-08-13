import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class CornBlightPage extends StatefulWidget {
  @override
  _CornBlightPageState createState() => _CornBlightPageState();
}

class _CornBlightPageState extends State<CornBlightPage> {
  bool isTreatNowSelected = true;

  void _shareContent() {
    String content = "Disease Name: Corn Blight Disease\n\n";

    content +=
        "Corn Blight is a fungal disease that primarily affects corn plants. It is characterized by the appearance of irregular brown or gray lesions on the leaves, which can lead to wilting and eventual death of the plant. The disease is commonly transmitted through infected seeds or spores present in the soil. To mitigate the impact of Corn Blight, it is essential to utilize disease-resistant corn varieties and implement effective crop rotation and sanitation measures.\n";

    content +=
        "> Symptoms:\n• Yellow or brown spots on the leaves\n• Lesions with irregular margins\n• Wilting or drooping of the leaves\n• Stunted growth of the plant\n\n";

    content +=
        "> More Info:\n• Scientific Name: Gibberella zeae\n• Also Found In: Wheat, Barley, Rice\n\n";

    content += "> Treat Now:\n";
    content +=
        "Recommendations:\nApply fungicides to affected areas as per recommended dosage and frequency. Remove and destroy infected plants to prevent further spread. Practice crop rotation to reduce disease recurrence. Ensure proper drainage to prevent waterlogged conditions. Plant disease-resistant corn varieties. Maintain good overall plant health and nutrition. Keep the surrounding area free from weeds and debris. Monitor weather conditions and moisture levels regularly. Consult with local agricultural experts for specific recommendations.\n\n";

    content +=
        "> Pesticides: Here are the recommended pesticides to cure corn Blight:\n";
    content +=
        "• Chlorothalonil: \n Apply Chlorothalonil-based fungicides to the affected corn areas following the recommended dosage and frequency. Chlorothalonil is effective in controlling fungal diseases and can help suppress Corn Blight.\n\n";
    content +=
        "• Mancozeb: \n Use Mancozeb-based fungicides as directed to treat Corn Blight. Mancozeb provides good control over fungal pathogens, including those causing Corn Blight.\n\n";
    content +=
        "• Copper-Based Fungicides: \n Copper fungicides are another option for managing Corn Blight. Follow the instructions on the product label for proper application.\n\n";
    content += "> Treat Now:\n";
    content +=
        "Preventive Measures:\nTo prevent Corn Blight disease, consider the following measures:\n• Implement a proper crop rotation plan to reduce the risk of disease recurrence in subsequent corn plantings.\n• Opt for disease-resistant corn varieties that have been specifically developed to withstand Corn Blight infection.\n• Remove and destroy any infected plant material to prevent the spread of the disease.\n• Ensure proper drainage to prevent waterlogged conditions, which can create a favorable environment for disease development.\n• Keep the surrounding area free from weeds and debris that can harbor the disease-causing pathogens.\n\n";

    content +=
        "> Fertilizers:\nRecommended fertilizers for healthy corn growth:\n";
    content +=
        "• Urea: Apply Urea fertilizer to provide a high concentration of nitrogen, which is essential for corn growth and development.\n";
    content +=
        "• Ammonium Nitrate: Use Ammonium Nitrate fertilizer to supply nitrogen and improve corn yield. Follow recommended application rates.\n";
    content +=
        "• Calcium Nitrate: Calcium Nitrate fertilizer can provide calcium and nitrogen to support healthy corn growth. Follow recommended guidelines for application.\n\n";

    content += "> What Caused It?\n";
    content +=
        "Corn Blight is primarily caused by the fungal pathogen Gibberella zeae. The disease can be transmitted through infected seeds or spores present in the soil. Environmental conditions, such as high humidity and moisture, create a favorable environment for the disease to develop and spread. Implementing preventive measures and using disease-resistant corn varieties can help reduce the risk of Corn Blight infection.";

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
                      'Corn Blight Disease',
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
                    'assets/images/corn/cornblight1.jpg',
                    'assets/images/corn/cornblight2.jpg',
                    'assets/images/corn/cornblight3.jpg',
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
                    'Corn Blight is a fungal disease that primarily affects corn plants. It is characterized by the appearance of irregular brown or gray lesions on the leaves, which can lead to wilting and eventual death of the plant. The disease is commonly transmitted through infected seeds or spores present in the soil. To mitigate the impact of Corn Blight, it is essential to utilize disease-resistant corn varieties and implement effective crop rotation and sanitation measures.',
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
                              'Yellow or brown spots on the leaves'),
                          _buildBulletDot('Lesions with irregular margins'),
                          _buildBulletDot('Wilting or drooping of the leaves'),
                          _buildBulletDot('Stunted growth of the plant'),
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
                              text: 'Gibberella zeae',
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
                        '• Also Found In: Wheat, Barley, Rice',
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
                          'Apply fungicides to affected areas as per recommended dosage and frequency. Remove and destroy infected plants to prevent further spread. Practice crop rotation to reduce disease recurrence. Ensure proper drainage to prevent waterlogged conditions. Plant disease-resistant corn varieties. Maintain good overall plant health and nutrition. Keep the surrounding area free from weeds and debris. Monitor weather conditions and moisture levels regularly. Consult with local agricultural experts for specific recommendations.',
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
                          'Here are some recommended pesticides to cure Corn Blight:',
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
                                    text: 'Chlorothalonil',
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
                              'Apply Chlorothalonil-based fungicides to the affected corn areas following the recommended dosage and frequency. Chlorothalonil is effective in controlling fungal diseases and can help suppress Corn Blight.',
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
                                    text: 'Mancozeb',
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
                              'Use Mancozeb-based fungicides as directed to treat Corn Blight. Mancozeb provides good control over fungal pathogens, including those causing Corn Blight.',
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
                                    text: 'Copper-Based Fungicides',
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
                              'Copper fungicides are another option for managing Corn Blight. Follow the instructions on the product label for proper application.',
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
                          'To prevent Corn Blight disease, consider the following measures:',
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                        SizedBox(height: 12),

                        // Customized Bulleted List of Preventive Measures
                        ListBody(
                          children: [
                            _buildBulletDot(
                                'Implement a proper crop rotation plan to reduce the risk of disease recurrence in subsequent corn plantings.'),
                            _buildBulletDot(
                                'Opt for disease-resistant corn varieties that have been specifically developed to withstand Corn Blight infection.'),
                            _buildBulletDot(
                                'Remove and destroy any infected plant material to prevent the spread of the disease.'),
                            _buildBulletDot(
                                'Ensure proper drainage to prevent waterlogged conditions, which can create a favorable environment for disease development.'),
                            _buildBulletDot(
                                'Keep the surrounding area free from weeds and debris that can harbor the disease-causing pathogens.'),
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
                          'Here are some recommended fertilizers for healthy corn growth:',
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
                                    text: 'Urea',
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
                              'Apply Urea fertilizer to provide a high concentration of nitrogen, which is essential for corn growth and development.',
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
                                    text: 'Ammonium Nitrate',
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
                              'Use Ammonium Nitrate fertilizer to supply nitrogen and improve corn yield. Follow recommended application rates.',
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
                              'Calcium Nitrate fertilizer can provide calcium and nitrogen to support healthy corn growth. Follow recommended guidelines for application.',
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
                        'Corn Blight is primarily caused by the fungal pathogen Gibberella zeae. It spreads through infected seeds, spores in the soil, and thrives in conditions of high humidity and moisture. The fungus enters the corn plant through wounds or natural openings, leading to the characteristic symptoms of the disease. Soil and crop residues from previous infected crops can contribute to further outbreaks. Using disease-resistant corn varieties and practicing proper crop rotation and sanitation are crucial preventive measures to reduce the risk of Corn Blight. Monitoring weather conditions and moisture levels also helps prevent its spread and damage to corn crops.',
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
