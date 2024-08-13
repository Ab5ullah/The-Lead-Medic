import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/cultivation/wheat/wheat_culture.dart';
import 'package:the_leaf_medic/cultivation/wheat/wheat_detail.dart';

class WheatDetailPage extends StatefulWidget {
  @override
  _WheatDetailPageState createState() => _WheatDetailPageState();
}

class _WheatDetailPageState extends State<WheatDetailPage> {
  bool _isAsideVisible = false;
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/wheat/wheatfield.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // Top left section with suitable temperature and sun icon
          Positioned(
            top: 50,
            left: 12,
            child: Row(
              children: [
                Icon(
                  Icons.wb_sunny,
                  color: Colors.yellow,
                ),
                SizedBox(width: 8),
                Text(
                  'Suitable Temperature: 15-25°C',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Side Panel with round containers (can be hidden)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: _isAsideVisible ? 12 : -100,
            child: AnimatedOpacity(
              opacity: _isAsideVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  // Navigate to "DetailsScreen" when "Details" container is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WheatDetailsPage(),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 170,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(137, 10, 10, 10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRoundCircleContainer('Details'),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigate to "CultureScreen" when "Culture" container is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WheatCulturePage(),
                            ),
                          );
                        },
                        child: _buildRoundCircleContainer('Culture'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom Centered content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 22),
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Wheat',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 7),
                      Image.asset(
                        'assets/images/wheat/wheat_culti.png',
                        width: 28,
                        height: 25,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(Triticum)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 19),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showFullText = !_showFullText; // Toggle state
                      });
                    },
                    child: AnimatedCrossFade(
                      duration: Duration(milliseconds: 300),
                      firstChild: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cherries are a prized fruit crop in Pakistan...',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            ' Read more',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      secondChild: Text(
                        'Cherries are a prized fruit crop in Pakistan, particularly renowned for their vibrant color and sweet-tart flavor. The country’s cherry cultivation is predominantly concentrated in the northern regions, such as Gilgit-Baltistan and parts of Khyber Pakhtunkhwa, where the climate and altitude create ideal growing conditions. Cherries not only contribute to the local agricultural economy but also offer potential for export, providing a valuable source of income for farmers. Known for their nutritional benefits and culinary versatility, cherries are an integral part of Pakistan\'s horticulture sector.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      crossFadeState: _showFullText
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    ),
                  ),
                  Text(
                    'Wheat is a vital staple crop in Pakistan, thriving in cooler climates and well-drained soils. As a primary food grain, it plays a crucial role in providing sustenance to the population, contributes significantly to the country\'s agricultural sector and the national diet.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),

          // Toggle side panel visibility button
          Positioned(
            top: MediaQuery.of(context).size.height * 0.82,
            right: 5,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isAsideVisible = !_isAsideVisible;
                });
              },
              child: Icon(
                _isAsideVisible ? Icons.close : Icons.menu,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundCircleContainer(String text) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: WheatDetailPage(),
  ));
}
