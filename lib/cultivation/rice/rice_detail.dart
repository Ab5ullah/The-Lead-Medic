import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class RiceDetailsPage extends StatefulWidget {
  @override
  _RiceDetailsPageState createState() => _RiceDetailsPageState();
}

class _RiceDetailsPageState extends State<RiceDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/rice/ricebasic.jpeg',
    'assets/images/rice/riceprocess.jpeg',
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
          'Rice Cultivation Details',
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
          'Rice holds significant importance as a staple food crop in Pakistan. It is a widely cultivated cereal grain that plays a crucial role in ensuring food security and meeting the dietary needs of the population. Rice cultivation is deeply integrated into the agricultural sector, providing livelihoods for many farmers and supporting the overall economy.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Rice is a primary food source for a large portion of the Pakistani population. It is a major component of the daily diet and contributes essential calories and nutrients to the people\'s well-being. Additionally, rice is a vital commodity for export, contributing to foreign exchange earnings for the country. The livestock industry also relies on rice straw as feed for animals.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Rice cultivation is prevalent in various regions of Pakistan. The major rice-growing provinces include Punjab, Sindh, and some parts of Khyber Pakhtunkhwa and Balochistan. Each region exhibits distinct climatic conditions and soil types, influencing rice farming practices and crop varieties.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Rice is typically cultivated during the Kharif season, starting from May and extending until July. The harvesting period occurs between September and November. Pakistan\'s warm and humid climate, with temperatures ranging from 25°C to 35°C (77°F to 95°F), provides an ideal environment for rice growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Rice thrives in well-drained, clayey, or loamy soil with good water-holding capacity. It requires sufficient water for optimal growth, making it suitable for cultivation in regions with ample irrigation facilities. The ideal soil pH for rice cultivation ranges from 6.0 to 7.5.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Rice Varieties',
          Icons.category,
          'Pakistan cultivates a diverse range of rice varieties, both aromatic and non-aromatic. Some popular aromatic varieties include Basmati and Super Basmati, while non-aromatic varieties include IRRI-6 and IRRI-9.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Rice',
          Icons.local_dining,
          'Rice is a staple food in Pakistan and is consumed in various forms, such as boiled rice, rice flour, and rice-based snacks. It is also a significant export commodity, contributing to the country\'s economic growth.',
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
          'Land Preparation',
          Icons.agriculture,
          'Choose flat or slightly sloping land with good water retention capacity. Level the field and create bunds to manage water effectively. Plow the land and puddle the soil to improve water infiltration.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Select high-quality rice seeds suitable for the local climate and variety. Treat the seeds with fungicides and insecticides to protect against diseases and pests.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Transplanting',
          Icons.local_florist,
          'Directly sow pre-germinated seeds in a well-prepared field. Maintain row-to-row spacing of 20-25 cm.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Grain Formation',
          Icons.grain,
          'Ensure adequate water and nutrient supply during flowering and grain formation. Avoid water stress during this critical stage.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.emoji_nature_sharp,
          'Observe physical signs, such as the yellowing of leaves and hardening of grains, to determine maturity. Harvest the crop when the majority of grains have reached physiological maturity. Cut the panicles manually using sickles or use mechanized harvesters.',
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
          'Water Management',
          Icons.water,
          'Sugarcane requires sufficient and timely irrigation throughout its growth stages. Proper water management ensures optimal plant growth and sugar accumulation. ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization',
          Icons.settings_input_antenna,
          'Balanced fertilization, including nitrogen, phosphorus, and potassium, supports healthy sugarcane development and higher sugar yields.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed control measures, such as manual weeding or the use of herbicides, are employed to reduce weed competition and maximize sugarcane productivity.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Regular monitoring helps farmers detect and manage pests and diseases affecting sugarcane. Appropriate pesticides and fungicides are applied to protect the crop from threats like sugarcane borers and rust diseases.',
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
    home: RiceDetailsPage(),
  ));
}
