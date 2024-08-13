import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CherryDetailsPage extends StatefulWidget {
  @override
  _CherryDetailsPageState createState() => _CherryDetailsPageState();
}

class _CherryDetailsPageState extends State<CherryDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/cherry/cherrybasic.jpeg',
    'assets/images/cherry/cherryprocess.jpeg',
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
          'Cherry Cultivation Details',
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
          'Cherries are an important fruit crop known for their sweet and tart varieties. They are widely grown in regions with temperate climates, contributing significantly to local economies and agricultural diversity.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Cherries hold economic value due to their popularity and demand. They are used in various culinary dishes and processed products, making them a valuable crop for farmers and the food industry.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Cherries are grown in temperate regions worldwide, with significant production in Gilgit-Baltistan and Balochistan. These areas provide the ideal conditions for cherry cultivation.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Cherries require a temperate climate with cool winters and mild summers. The ideal temperature range for cherry growth is between 15°C to 25°C, which supports healthy development and fruit production.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Cherries thrive in well-drained, sandy loam or loamy soils with good organic matter. The optimal soil pH for cherry cultivation is between 6.0 to 7.0.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Cherry Varieties',
          Icons.category,
          'There are several varieties of cherries, including sweet cherries like Bing and Rainier, and tart cherries such as Montmorency. These varieties are selected based on climate adaptability and market demand.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Cherry',
          Icons.local_dining,
          'Cherries are consumed fresh, dried, or processed into products like jams, juices, and desserts. They are also used in baking and cooking, adding flavor and nutrition to various dishes.',
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
          'Select well-drained and fertile land with good sunlight exposure for cherry cultivation. Prepare the field by plowing and leveling to create a suitable seedbed. Remove any weeds or debris from the field.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Choose high-quality cherry saplings suitable for the local climate and pest resistance. Ensure the saplings are disease-free and healthy for better growth and yield.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Create nurseries for raising cherry seedlings. Transplant the seedlings into the main field after they reach a suitable age (around 1-2 years).',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Boll Formation',
          Icons.grain,
          'During flowering and fruit formation, provide sufficient water and nutrients for proper development. Monitor the crop for pests and diseases, and take appropriate actions if infestations occur.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Picking Preparation',
          Icons.cut,
          'During flowering and fruit formation, provide sufficient water and nutrients for proper development. Monitor the crop for pests and diseases, and take appropriate actions if infestations occur.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Harvest the cherries when they are mature and fully developed. Use manual labor or mechanical harvesters for efficient and timely harvesting.',
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
          'Cherries require regular and well-timed irrigation for optimal growth and yield. Farmers employ various irrigation methods, such as drip irrigation, depending on the availability of water resources and local practices.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Cotton',
          Icons.settings_input_antenna,
          'Balanced fertilization is essential for maximizing cherry yields. Farmers apply nitrogen, phosphorus, and potassium fertilizers based on soil nutrient analysis and crop requirements.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed management is crucial to prevent weed competition and maximize cherry yields. Use herbicides or adopt manual weeding practices to control weeds in the cherry orchards.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Cherries are susceptible to various insect pests and diseases. Monitor the crop for pest infestations and apply appropriate pesticides when necessary to protect the cherry plants from damage.',
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
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: CherryDetailsPage(),
  ));
}
