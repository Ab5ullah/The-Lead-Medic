import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AppleBlackRotPage extends StatefulWidget {
  @override
  _AppleBlackRotPageState createState() => _AppleBlackRotPageState();
}

class _AppleBlackRotPageState extends State<AppleBlackRotPage> {
  bool isTreatNowSelected = true;

  void _shareContent() {
    String content = "Disease Name: Apple Black Rot Disease\n\n";

    content +=
        "Apple Black Rot is a fungal disease that primarily affects apple trees. It is characterized by the appearance of dark, sunken lesions on the fruit, leaves, and bark, which can lead to fruit rot and cankers on the branches. The disease is commonly transmitted through fungal spores present on fallen leaves, infected fruit, and cankers on the tree. To mitigate the impact of Apple Black Rot, it is essential to utilize disease-resistant apple varieties and implement effective sanitation and cultural practices.\n";

    content +=
        "> Symptoms:\n• Dark, sunken lesions on fruit\n• Leaf spots that turn purple and then black\n• Cankers on branches and twigs\n• Fruit rot\n\n";

    content +=
        "> More Info:\n• Scientific Name: Botryosphaeria obtusa\n• Also Found In: Pear, Quince, Hawthorn\n\n";

    content += "> Treat Now:\n";
    content +=
        "Recommendations:\nApply fungicides to affected areas as per recommended dosage and frequency. Remove and destroy infected fruit and leaves to prevent further spread. Prune out cankers during the dormant season. Improve air circulation through proper pruning. Practice good sanitation by cleaning up fallen leaves and fruit. Plant disease-resistant apple varieties. Maintain good overall tree health and nutrition. Monitor weather conditions and moisture levels regularly. Consult with local agricultural experts for specific recommendations.\n\n";

    content +=
        "> Pesticides: Here are the recommended pesticides to cure Apple Black Rot:\n";
    content +=
        "• Captan: \n Apply Captan-based fungicides to the affected areas following the recommended dosage and frequency. Captan is effective in controlling fungal diseases and can help suppress Apple Black Rot.\n\n";
    content +=
        "• Mancozeb: \n Use Mancozeb-based fungicides as directed to treat Apple Black Rot. Mancozeb provides good control over fungal pathogens, including those causing Apple Black Rot.\n\n";
    content +=
        "• Copper-Based Fungicides: \n Copper fungicides are another option for managing Apple Black Rot. Follow the instructions on the product label for proper application.\n\n";
    content += "> Treat Now:\n";
    content +=
        "Preventive Measures:\nTo prevent Apple Black Rot disease, consider the following measures:\n• Implement a proper sanitation plan by removing fallen leaves and infected fruit to reduce the risk of disease recurrence.\n• Opt for disease-resistant apple varieties that have been specifically developed to withstand Apple Black Rot infection.\n• Prune apple trees to improve air circulation and reduce humidity around the foliage, which can help prevent the disease.\n• Apply fungicides as a preventive measure during the growing season.\n• Ensure proper spacing between trees to allow for adequate air circulation.\n\n";

    content +=
        "> Fertilizers:\nRecommended fertilizers for healthy apple tree growth:\n";
    content +=
        "• NPK (Nitrogen, Phosphorus, Potassium): Apply a balanced NPK fertilizer to support overall growth and fruit development.\n";
    content +=
        "• Calcium Nitrate: Use Calcium Nitrate fertilizer to provide calcium and nitrogen, essential for healthy apple growth. Follow recommended guidelines for application.\n";
    content +=
        "• Potassium Sulfate: Potassium Sulfate fertilizer can supply potassium, which is vital for fruit quality and disease resistance. Follow recommended application rates.\n\n";

    content += "> What Caused It?\n";
    content +=
        "Apple Black Rot is primarily caused by the fungal pathogen Botryosphaeria obtusa. The disease can be transmitted through fungal spores present on fallen leaves, infected fruit, and cankers on the tree. Environmental conditions, such as wet and humid weather, create a favorable environment for the disease to develop and spread. Implementing preventive measures and using disease-resistant apple varieties can help reduce the risk of Apple Black Rot infection.";

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
                      'Apple Black Rot Disease',
                      style: TextStyle(
                        fontSize: 20,
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
                    'assets/images/apple/black_rot1.jpg',
                    'assets/images/apple/black_rot2.jpg',
                    'assets/images/apple/black_rot3.jpg',
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
                    'Apple Black Rot is a fungal disease that primarily affects apple trees. It is characterized by the appearance of dark, sunken lesions on the fruit, leaves, and bark, which can lead to fruit rot and cankers on the branches. The disease is commonly transmitted through fungal spores present on fallen leaves, infected fruit, and cankers on the tree. To mitigate the impact of Apple Black Rot, it is essential to utilize disease-resistant apple varieties and implement effective sanitation and cultural practices.',
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
                          _buildBulletDot('Dark, sunken lesions on fruit'),
                          _buildBulletDot(
                              'Leaf spots that turn purple and then black'),
                          _buildBulletDot('Cankers on branches and twigs'),
                          _buildBulletDot('Fruit rot'),
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
                              text: 'Botryosphaeria obtusa',
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
                        '• Also Found In: Pear, Quince, Hawthorn',
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
                          'Apply fungicides to affected areas as per recommended dosage and frequency. Remove and destroy infected fruit and leaves to prevent further spread. Prune out cankers during the dormant season. Improve air circulation through proper pruning. Practice good sanitation by cleaning up fallen leaves and fruit. Plant disease-resistant apple varieties. Maintain good overall tree health and nutrition. Monitor weather conditions and moisture levels regularly. Consult with local agricultural experts for specific recommendations.',
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
                          'Here are some recommended pesticides to cure Apple Black Rot:',
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
                                    text: 'Captan',
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
                              'Use Mancozeb-based fungicides as directed to treat Apple Black Rot. Mancozeb provides good control over fungal pathogens, including those causing Apple Black Rot.',
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
                              'Copper fungicides are another option for managing Apple Black Rot. Follow the instructions on the product label for proper application.',
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
                          'To prevent Apple Black Rot disease, consider the following measures:',
                          style: TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                        SizedBox(height: 12),

                        // Customized Bulleted List of Preventive Measures
                        ListBody(
                          children: [
                            _buildBulletDot(
                                'Implement a proper sanitation plan by removing fallen leaves and infected fruit to reduce the risk of disease recurrence.'),
                            _buildBulletDot(
                                'Opt for disease-resistant apple varieties that have been specifically developed to withstand Apple Black Rot infection.'),
                            _buildBulletDot(
                                'Remove and destroy any infected plant material to prevent the spread of the disease.'),
                            _buildBulletDot(
                                'Prune apple trees to improve air circulation and reduce humidity around the foliage, which can help prevent the disease.'),
                            _buildBulletDot(
                                'Ensure proper spacing between trees to allow for adequate air circulation.'),
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
                          'Here are some recommended fertilizers for healthy Apple tree growth:',
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
                                    text:
                                        'NPK (Nitrogen, Phosphorus, Potassium)',
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
                              'Apply a balanced NPK fertilizer to support overall growth and fruit development.',
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
                              'Use Calcium Nitrate fertilizer to provide calcium and nitrogen, essential for healthy apple growth. Follow recommended guidelines for application.',
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
                                    text: 'Potassium Sulfate',
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
                              'Potassium Sulfate fertilizer can supply potassium, which is vital for fruit quality and disease resistance. Follow recommended application rates.',
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
                        'Apple Black Rot is primarily caused by the fungal pathogen Botryosphaeria obtusa. The disease can be transmitted through fungal spores present on fallen leaves, infected fruit, and cankers on the tree. Environmental conditions, such as wet and humid weather, create a favorable environment for the disease to develop and spread. Implementing preventive measures and using disease-resistant apple varieties can help reduce the risk of Apple Black Rot infection.',
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

                              // Add the link to your Facebook account
                              // when the icon is tapped.
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
                              _launchURL('mailto:thebotanicscanner@gmail.com');

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
