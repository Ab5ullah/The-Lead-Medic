import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class GrapeDetailsPage extends StatefulWidget {
  @override
  _GrapeDetailsPageState createState() => _GrapeDetailsPageState();
}

class _GrapeDetailsPageState extends State<GrapeDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/grape/grapebasic.jpeg',
    'assets/images/grape/grapeprocess.jpeg',
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
          'Grape Cultivation Details',
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
          'Grapes are a prominent fruit crop in Pakistan, known for their economic significance and nutritional value. They are cultivated across various regions of the country, contributing significantly to agricultural production and local economies.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Grapes play a vital role in Pakistan\'s horticulture sector, serving as a valuable export commodity and contributing to the national GDP. They are widely consumed domestically and are processed into various products such as juices, jams, and wines.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Grapes thrive in diverse agro-climatic conditions across Pakistan, with major cultivation areas including Punjab, Balochistan, and parts of Sindh. These regions benefit from suitable soil types and favorable weather patterns for grape cultivation.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Grapes are typically grown as a summer crop in Pakistan, requiring warm temperatures ranging from 15°C to 40°C (59°F to 104°F) during the growing season. Adequate sunlight and moderate rainfall are essential for optimal grape growth and fruit development.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Grapes prefer well-drained sandy loam or loamy soils with good fertility and pH levels ranging from 6.0 to 7.5. Proper soil preparation and management are crucial for maximizing grape yields and quality.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Grape Varieties',
          Icons.category,
          'Pakistan cultivates a variety of grape cultivars, including both table grapes and those used for wine production. Popular varieties grown include Thompson Seedless, Flame Seedless, and Black Muscat, adapted to local growing conditions.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Grape',
          Icons.local_dining,
          'Grapes are utilized for fresh consumption, dried as raisins, or processed into juices and wines. The grape processing industry in Pakistan adds value to the crop, supporting economic growth and employment in rural areas.',
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
          'Prior to planting, farmers prepare the soil by ensuring it is well-drained and free from weeds. Proper land leveling and soil amendments are performed to create an optimal environment for grapevine establishment.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Grapes are propagated vegetatively through cuttings or grafting. Farmers select high-quality grapevine cuttings or plants suited to the local climate and soil conditions for optimal growth and yield.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Grapevines are typically planted in rows with adequate spacing to facilitate sunlight penetration and airflow. Planting is done during the dormant season, ensuring roots establish well before the onset of vigorous growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Boll Formation',
          Icons.grain,
          'Grapes undergo flowering and fruit set during the growing season. Adequate water supply and balanced fertilization are essential for proper fruit development and sugar accumulation. Monitoring for pest and disease outbreaks is critical to prevent damage to grape clusters.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Picking Preparation',
          Icons.cut,
          'Prior to harvesting, grape growers prepare by assessing vineyard readiness and grape maturity. They inspect clusters for optimal ripeness, checking sugar levels and flavor development. Equipment such as harvesting shears and bins are readied, and labor is organized to ensure efficient and timely harvesting.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Grapes are harvested at optimal ripeness, typically by hand to avoid damaging the delicate clusters. Harvest timing varies by grape variety and intended use, ensuring grapes are flavorful and retain quality during processing. Grapes destined for drying are left on the vine longer to reach desired sugar levels.',
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
          'Grapes require regular irrigation during the growing season to maintain soil moisture levels essential for vine health and fruit development. Drip irrigation systems are commonly used to deliver water efficiently directly to the root zone.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Cotton',
          Icons.settings_input_antenna,
          'Balanced fertilization with nitrogen, phosphorus, and potassium is crucial for grapevine growth and fruit production. Soil and tissue analysis guide fertilization practices to ensure optimal nutrient uptake and vine vigor.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed management in vineyards prevents competition for nutrients and reduces the risk of vineyard pests. Mulching and herbicide applications are common practices to control weeds without impacting grapevine health.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Grapes are susceptible to various pests and diseases, including powdery mildew, downy mildew, and grapevine leafroll disease. Integrated pest management (IPM) strategies are employed, which may include biological controls, cultural practices, and judicious use of pesticides to minimize damage and maintain grape health.',
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
    home: GrapeDetailsPage(),
  ));
}
