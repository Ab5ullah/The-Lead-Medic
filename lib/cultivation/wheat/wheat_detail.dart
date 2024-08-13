import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class WheatDetailsPage extends StatefulWidget {
  @override
  _WheatDetailsPageState createState() => _WheatDetailsPageState();
}

class _WheatDetailsPageState extends State<WheatDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/wheat/wheatbasic.jpeg',
    'assets/images/wheat/wheatprocess.jpeg',
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
          'Wheat Cultivation Details',
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
          'Wheat is a staple cereal crop and a fundamental food source in Pakistan. It is one of the most extensively cultivated crops, serving as a primary dietary component for the population. Wheat production plays a crucial role in ensuring food security and contributing to the country\'s economy.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Wheat is a staple food grain for the majority of Pakistan\'s population. It provides essential calories and nutrients, making it a critical component of the daily diet. Wheat cultivation also serves as a source of income and livelihood for millions of farmers across the country.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Wheat is grown in various regions of Pakistan, with Punjab being the largest wheat-producing province, followed by Sindh and Khyber Pakhtunkhwa. These regions have diverse climatic conditions, allowing for multiple wheat crops in a year.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Wheat is primarily a Rabi crop in Pakistan, sown from October to December and harvested from April to June. The country\'s mild winters and moderate temperatures, ranging from 5°C to 25°C (41°F to 77°F), create favorable conditions for wheat growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Wheat thrives in well-drained, fertile soils with good moisture retention capacity. Sandy loam and clay loam soils are suitable for wheat cultivation. The ideal soil pH for wheat ranges from 6.0 to 7.5.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Wheat Varieties',
          Icons.category,
          'Pakistan cultivates various wheat varieties, each adapted to specific agro-climatic regions. Some popular wheat varieties include Sehar-2006, Inqalab-91, and Aas-2011. ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Wheat',
          Icons.local_dining,
          'Wheat is processed into various food products, including flour, which is used to make bread, chapati, and other traditional dishes. It serves as a crucial dietary component for the Pakistani population.',
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
          'Select well-drained and fertile land with good water retention capacity for wheat cultivation. Prepare the field by plowing and leveling to create a smooth and even seedbed. Remove any weeds and debris from the field to avoid competition with wheat plants.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Choose high-quality wheat seeds suitable for the local climate and variety. Treat the seeds with appropriate fungicides and insecticides to protect against diseases and pests.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Plant the wheat seeds directly into the prepared field at the recommended depth. Maintain adequate spacing between rows for proper tillering and growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Grain Development',
          Icons.grain,
          'Provide sufficient water and nutrients during the flowering and grain development stages. Monitor the crop for diseases like rust and take appropriate actions if needed.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Observe the crop for physical signs of maturity, such as yellowing of leaves and fully developed grains. Harvest the wheat crop when most of the grains have reached physiological maturity. Use combine harvesters or manual labor for efficient and timely harvesting.',
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
          'Timely and sufficient irrigation is crucial during the wheat growing season to meet the crop\'s water requirements.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for wheat',
          Icons.settings_input_antenna,
          'Apply balanced fertilizers, including nitrogen, phosphorus, and potassium, to support healthy wheat growth and yield. ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed control measures, such as manual weeding or herbicide application, are implemented to minimize competition for nutrients and water.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Regular monitoring helps farmers detect and manage pests and diseases affecting wheat. Proper measures, including the use of pesticides and fungicides, are employed when necessary.',
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
    home: WheatDetailsPage(),
  ));
}
