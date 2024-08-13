import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CornDetailsPage extends StatefulWidget {
  @override
  _CornDetailsPageState createState() => _CornDetailsPageState();
}

class _CornDetailsPageState extends State<CornDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/corn/cornbasic.jpeg',
    'assets/images/corn/cornprocess.jpeg',
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
          'Corn Cultivation Details',
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
          'Corn, also known as maize, is a significant cereal crop cultivated in Pakistan. It is a staple food for many people and plays a vital role in the country\'s agriculture sector.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Corn is an essential food source for both humans and livestock in Pakistan.It contributes to food security, providing calories and essential nutrients to the population.The livestock industry heavily relies on corn as a primary feed ingredient.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Corn is grown in various regions across Pakistan, with major cultivation in Punjab, Sindh, Khyber Pakhtunkhwa, and Balochistan.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Corn is predominantly cultivated during the Kharif season, which starts from May and extends until July. The harvesting period occurs between September and November.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Corn Varieties',
          Icons.category,
          'Pakistan cultivates a range of corn varieties, including hybrid and open-pollinated varieties. Some popular corn varieties grown in Pakistan include Azam, Kissan, and Sona.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Corn',
          Icons.local_dining,
          'Corn in Pakistan is used in various forms, including cornmeal, cornflour, and popcorn, for human consumption. It is also a valuable source of animal feed, supporting the livestock industry.',
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
          'Choose a location with well-drained soil. The optimal temperature range of 20°C to 30°C (68°F to 86°F) is uitable for corn growth. Plowing the land to a fine tilth and enriching the soil with organic matter. The target soil pH range is 6.0 to 7.5.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Select high-quality corn seeds with good germination rates. Treat the seeds with fungicides and insecticides to safeguard against diseases and pests.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Implement efficient irrigation practices to ensure adequate water supply throughout the growing season. Monitor soil moisture levels and adjust irrigation accordingly.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Early Crop Care',
          Icons.favorite,
          'Provide sufficient irrigation to aid germination and early growth. Employ manual or chemical methods to control weeds and apply additional fertilizers if needed based on soil and plant nutrient requirements.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Crop Devlopment',
          Icons.spa,
          'Diligently monitor and manage pests and diseases during this phase. The optimal temperature range during crop growth is 20°C to 35°C (68°F to 95°F).',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Mid Season Care',
          Icons.healing,
          'Apply side dressing of nitrogen-based fertilizers to promote healthy development. Monitor weather conditions for heat stress and provide shade if necessary.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Reproductive Stage',
          Icons.local_florist,
          'Ensure proper pollination by wind or manual methods. Maintaining soil moisture during flowering and grain-filling stages is vital. Avoid prolonged exposure to extreme temperatures above 35°C (95°F).',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting Time',
          Icons.nature,
          'Harvest the corn when kernels are fully matured and dry. The optimal harvesting temperature range is 20°C to 30°C (68°F to 86°F).',
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
          'Regularly monitor soil moisture levels and water the crop as needed to avoid water stress, which can negatively impact yield.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Corn',
          Icons.settings_input_antenna,
          'Implement a balanced fertilization plan based on soil nutrient analysis and corn\'s growth stage. Provide sufficient nitrogen, phosphorus, and potassium to support healthy plant growth and optimize yields.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Practice effective weed management to reduce weed competition and improve corn growth.Use herbicides or opt for manual weeding to keep the corn field weed-free during the early growth stages.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Monitor the corn crop regularly for signs of pests and diseases. Take timely action to control and manage common corn pests such as armyworms, corn borers, and aphids.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Gap Filling',
          Icons.cut,
          'Thin out excess plants to maintain an optimal plant density, allowing sufficient space for each plant to grow. Fill any gaps in the rows to ensure uniformity in plant distribution and maximize yield potential.',
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
    home: CornDetailsPage(),
  ));
}
