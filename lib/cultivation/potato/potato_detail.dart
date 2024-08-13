import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class PotatoDetailsPage extends StatefulWidget {
  @override
  _PotatoDetailsPageState createState() => _PotatoDetailsPageState();
}

class _PotatoDetailsPageState extends State<PotatoDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/potato/potatobasic.jpeg',
    'assets/images/potato/potatoprocess.jpeg',
    'assets/images/care.jpeg'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.33, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.slowMiddle,
    ));

    // Trigger the animation for the non-default tabs (Process and Care)
    // This ensures that the animation works as expected when toggling between tabs
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Potato Cultivation Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: 16.0, right: 4.0, left: 4.0, bottom: 16),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                tabTitles.length,
                (index) =>
                    _buildTabButton(index, tabTitles[index], tabImages[index]),
              ),
            ),
          ),
          // Wrap in SingleChildScrollView and Expanded
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding:
                        EdgeInsets.all(16.0), // Add padding to the container
                    margin: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0), // Add margin
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius:
                          BorderRadius.circular(16.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      // Clip rounded corners for the child
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        tabImages[_selectedTab],
                        width: double
                            .infinity, // Take the full width of the container
                        height: 240,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _selectedTab == 0
                      ? _buildBasicInfo()
                      : _selectedTab == 1
                          ? _buildProcess()
                          : _buildCare(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int tabNumber, String title, String imageAsset) {
    return ElevatedButton(
      onPressed: () {
        if (_selectedTab != tabNumber) {
          setState(() {
            _selectedTab = tabNumber;
          });
          _animationController.reset();
          _animationController.forward();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTab == tabNumber
            ? Colors.orangeAccent // Active button color
            : Color.fromARGB(255, 158, 158, 158), // Inactive button color
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: _selectedTab == tabNumber
                ? Color.fromARGB(
                    255, 255, 255, 255) // Active button border color
                : Color.fromARGB(
                    0, 138, 101, 21), // Inactive button border color
            width: 2.0,
          ),
        ),
        elevation:
            _selectedTab == tabNumber ? 20 : 0, // Active button elevation
        minimumSize: Size(116, 43), // Increase button width
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBasicInfo() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildContainerWithIcon(
          'Introduction',
          Icons.info,
          'Potato (Solanum tuberosum) is a staple crop with significant economic and nutritional value. It is cultivated worldwide and is known for its versatility in culinary uses. In Pakistan, potato farming contributes to the livelihoods of many farmers and supports the food industry.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Potatoes are a vital part of the agricultural sector in Pakistan, serving as a major food source and an important cash crop. They play a crucial role in food security and are a staple in the Pakistani diet. Potatoes also provide raw materials for various processed food products.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Potatoes are grown in multiple regions across Pakistan, with major production areas including Punjab, Khyber Pakhtunkhwa, and Balochistan. These regions have suitable climatic conditions and soil types for potato cultivation.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Potatoes thrive in a cool and temperate climate with an ideal temperature range of 15°C to 20°C (59°F to 68°F). They require well-drained soil and adequate water supply during the growing season for optimal yield.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Potatoes grow best in well-drained, sandy loam or loam soils rich in organic matter. The optimal soil pH for potato cultivation is between 5.0 and 6.5. Good soil aeration is essential to prevent diseases and promote healthy tuber development.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Potato Varieties',
          Icons.category,
          'Pakistan cultivates various potato varieties, including local and improved types. Popular varieties include Diamant, Desiree, and Cardinal, which are chosen for their high yield, disease resistance, and suitability to local growing conditions.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Potato',
          Icons.local_dining,
          'Potatoes are used in a wide range of culinary applications, from fresh consumption to processed products like chips, fries, and dehydrated flakes. They are also used as animal feed and in industrial applications such as starch production.',
        ),
      ],
    );
  }

  Widget _buildProcess() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildContainerWithIcon(
          'Soil Preparation',
          Icons.agriculture,
          'Select well-drained and fertile land with good sunlight exposure for potato cultivation. Prepare the field by plowing and leveling to create a suitable seedbed. Remove any weeds or debris from the field.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Choose high-quality potato seeds suitable for the local climate and pest resistance. Treat the seeds with appropriate fungicides and insecticides to protect against diseases and pests.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Plant the potato seeds or seed pieces in well-prepared soil at the appropriate depth and spacing. Ensure proper irrigation and care during the initial stages to promote healthy sprout development.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Boll Formation',
          Icons.grain,
          'During tuber formation, provide sufficient water and nutrients for proper growth. Monitor the crop for pests and diseases, and take appropriate actions if infestations occur.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Picking Preparation',
          Icons.cut,
          'In preparation for harvest, reduce irrigation to allow the potato skins to mature and toughen. This helps in minimizing damage during harvesting and storage.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Harvest the potatoes when the plants have matured and the tubers have reached the desired size. Use manual labor or mechanical harvesters for efficient and timely harvesting.',
        ),
      ],
    );
  }

  Widget _buildCare() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildContainerWithIcon(
          'Proper Irrigation',
          Icons.water,
          'Potatoes require regular and well-timed irrigation for optimal growth and yield. Farmers employ various irrigation methods, such as flood irrigation or drip irrigation, depending on the availability of water resources and local practices.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Potato',
          Icons.settings_input_antenna,
          'Balanced fertilization is essential for maximizing potato yields. Farmers apply nitrogen, phosphorus, and potassium fertilizers based on soil nutrient analysis and crop requirements.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed management is crucial to prevent weed competition and maximize potato yields. Use herbicides or adopt manual weeding practices to control weeds in the potato fields.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Potatoes are susceptible to various insect pests and diseases. Monitor the crop for pest infestations and apply appropriate pesticides when necessary to protect the potato plants from damage.',
        ),
      ],
    );
  }

  Widget _buildContainerWithIcon(
    String heading,
    IconData iconData,
    String content,
  ) {
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
      margin: EdgeInsets.only(
          top: 16.0, left: 20, right: 20, bottom: 5), // Add horizontal margin
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, size: 30, color: AppColors.mainColor),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  heading,
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

void main() {
  runApp(GetMaterialApp(
    home: PotatoDetailsPage(),
  ));
}
