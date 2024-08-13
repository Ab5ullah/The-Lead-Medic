import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/cultivation/corn/corn_culture.dart';
import 'package:the_leaf_medic/cultivation/corn/corn_detail.dart';

class CornDetailPage extends StatefulWidget {
  @override
  _CornDetailPageState createState() => _CornDetailPageState();
}

class _CornDetailPageState extends State<CornDetailPage> {
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
              'assets/images/corn/cornfield.jpeg',
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
                  'Suitable Temperature: 20-30°C',
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
                      builder: (context) => CornDetailsPage(),
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
                              builder: (context) => CornCulturePage(),
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
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
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
                        'Corn ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/images/corn/corn_culti.png',
                        width: 28,
                        height: 25,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(Zea mays)',
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
                              'Corn is a vital and staple crop in Pakistan. It thrives...',
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
                        'Corn is a vital and staple crop in Pakistan. It thrives in warm climates and fertile soils, serving as a staple food, animal feed, and raw material for various industries. Its adaptability makes it well-suited for cultivation across different regions of the country.',
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
    home: CornDetailPage(),
  ));
}
