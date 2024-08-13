import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CottonDetailsPage extends StatefulWidget {
  @override
  _CottonDetailsPageState createState() => _CottonDetailsPageState();
}

class _CottonDetailsPageState extends State<CottonDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/cotton/cottonbasic.jpeg',
    'assets/images/cotton/cottonprocess.jpeg',
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
          'Cotton Cultivation Details',
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
          'Cotton is a vital cash crop in Pakistan and holds significant economic importance for the country. It is one of the major crops cultivated on a large scale, contributing significantly to the agricultural sector and the national economy.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Cotton is the backbone of Pakistan\'s textile industry, which is a major foreign exchange earner for the country. It is a primary raw material for producing textiles and garments, making Pakistan one of the leading cotton textile exporters globally. .',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Cotton is grown in various regions of Pakistan, with Punjab being the largest cotton-producing province, followed by Sindh. These regions possess favorable agro-climatic conditions which are conducive to cotton cultivation.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Cotton is primarily a Kharif crop in Pakistan, with sowing starting from April to June and harvesting taking place between September and December. The temperature ranging from 25°C to 40°C (77°F to 104°F) provides an ideal environment for cotton growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Cotton thrives in well-drained sandy loam or loam soil with good water-holding capacity. The optimal soil pH for cotton cultivation in Pakistan is between 7.0 to 8.0.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Cotton Varieties',
          Icons.category,
          'Pakistan cultivates various cotton varieties, including genetically modified (GM) and non-GM varieties. GM cotton varieties like Bt cotton have gained popularity due to their resistance against certain insect pests. Popular non-GM varieties include CIM-496, NIAB-878, and FH-142.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Cotton',
          Icons.local_dining,
          'Cotton is a primary raw material for Pakistan\'s textile industry. It is used to produce various textile products, including yarn, fabric, and garments, both for domestic consumption and export.',
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
          'Select well-drained and fertile land with good sunlight exposure for cotton cultivation.Prepare the field by plowing and leveling to create a suitable seedbed. Remove any weeds or debris from the field ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Choose high-quality cotton seeds suitable for the local climate and pest resistance.Treat the seeds with appropriate fungicides and insecticides to protect against diseases and pests.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Create nurseries for raising cotton seedlings.Transplant the seedlings into the main field after they reach a suitable age (around 25-30 days).',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Boll Formation',
          Icons.grain,
          'During flowering and boll formation, provide sufficient water and nutrients for proper fruit development. Monitor the crop for pests like bollworms and take appropriate actions if infestations occur.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Picking Preparation',
          Icons.cut,
          'In preparation for picking, defoliate the cotton plants to facilitate easy harvesting. Plan and organize the workforce and equipment needed for cotton picking.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Harvest the cotton bolls when they have matured and are fully developed. Use manual labor or mechanical cotton pickers for efficient and timely harvesting.',
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
          'Cotton requires regular and well-timed irrigation for optimal growth and yield. Farmers employ various irrigation methods, such as flood irrigation or drip irrigation, depending on the availability of water resources and local practices.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Cotton',
          Icons.settings_input_antenna,
          'Balanced fertilization is essential for maximizing cotton yields. Farmers apply nitrogen, phosphorus, and potassium fertilizers based on soil nutrient analysis and crop requirements. ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed management is crucial to prevent weed competition and maximize cotton yields. Use herbicides or adopt manual weeding practices to control weeds in the cotton fields.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Cotton is susceptible to various insect pests and diseases. Monitor the crop for pest infestations and apply appropriate pesticides when necessary to protect the cotton plants from damage.',
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
    home: CottonDetailsPage(),
  ));
}
