import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class SugarcaneDetailsPage extends StatefulWidget {
  @override
  _SugarcaneDetailsPageState createState() => _SugarcaneDetailsPageState();
}

class _SugarcaneDetailsPageState extends State<SugarcaneDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/sugarcane/sugarbasic.jpeg',
    'assets/images/sugarcane/sugarprocess.jpeg',
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
          'Sugarcane Cultivation Details',
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
          'Sugarcane holds significant agricultural importance in Pakistan as one of the major cash crops. It plays a vital role in the country\'s economy and agriculture sector. Sugarcane cultivation is widely practiced, providing a source of income and employment for many farmers and laborers.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Sugarcane is a primary source of sugar production in Pakistan. The sugar industry contributes significantly to the country\'s economic growth and provides essential sweeteners for domestic consumption. Additionally, sugarcane by-products, such as molasses and bagasse, are used in various industries and serve as feed for livestock.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Sugarcane is grown in different regions of Pakistan, with major cultivation concentrated in provinces like Punjab and Sindh. Each region\'s unique climatic conditions and soil characteristics influence sugarcane farming practices and crop varieties.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Sugarcane is typically planted during the spring season, starting from February to April. The harvesting period occurs between October and January. Pakistan\'s warm and semi-arid climate, with temperatures ranging from 20°C to 40°C (68°F to 104°F), provides suitable conditions for sugarcane growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Sugarcane thrives in well-drained, fertile soils with good water-holding capacity. Sandy loam and clay loam soils are considered ideal for sugarcane cultivation. The soil pH requirement for sugarcane is slightly acidic to neutral, ranging from 6.0 to 7.5.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sugarcane Varieties',
          Icons.category,
          'Pakistan cultivates various sugarcane varieties, each with distinct characteristics and adaptability to different regions. Some popular sugarcane varieties grown in Pakistan include CP-77-400, HSF-240, and SPSG-26. Farmers choose sugarcane varieties based on yield potential, sugar content, and disease resistance.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Sugarcane',
          Icons.local_dining,
          'Sugarcane is primarily used for sugar production, meeting the domestic demand and supporting the confectionery and food industries. Molasses, a by-product of sugar production, is used in the production of alcohol and animal feed.',
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
          'Select suitable land for sugarcane cultivation, preferably flat or slightly sloping with good water retention capacity. They level the field and create bunds to manage water effectively.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Choose healthy sugarcane setts (cane cuttings) as seeds for planting. These setts undergo treatment with fungicides and insecticides to prevent diseases and pests, ensuring successful cane establishment.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Transplanting',
          Icons.local_florist,
          'Raise sugarcane seedlings in a nursery and later transplant them into the main field at the age of 25-30 days. Adequate plant-to-plant spacing of 20-25 cm and row-to-row spacing of 25-30 cm are maintained. ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Grain Formation',
          Icons.grain,
          'Ensure adequate water and nutrient supply for healthy flowering and grain formation. Preventing water stress during this critical stage is vital for successful sugarcane yield.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Physical signs, such as the yellowing of leaves and hardening of canes, are observed to determine the maturity of sugarcane. Harvesting takes place when most of the canes have reached physiological maturity. The crop is manually cut at the base using machetes or mechanized harvesters.',
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
          'Rice is a semi-aquatic crop and requires continuous water availability throughout its growth stages. As the crop matures, water levels are gradually reduced to facilitate grain maturation and ease of harvesting.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Rice',
          Icons.settings_input_antenna,
          'Proper fertilization is crucial for maximizing rice yields. Farmers apply organic manure and balanced chemical fertilizers based on soil nutrient analysis and crop stage. Nitrogen, phosphorus, and potassium are the primary nutrients required for optimal rice growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Weed competition can significantly impact rice yield. Farmers employ both manual weeding and chemical herbicides to control weeds effectively and maintain a weed-free environment around the rice plants.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Regular monitoring of rice fields is essential to detect and manage pest and disease infestations promptly. Farmers use appropriate pesticides and fungicides to protect the crop from pests like rice stem borers, leaf folders, and diseases like blast and sheath blight.',
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
    home: SugarcaneDetailsPage(),
  ));
}
