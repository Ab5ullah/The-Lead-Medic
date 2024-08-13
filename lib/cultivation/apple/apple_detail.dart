import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class AppleDetailsPage extends StatefulWidget {
  @override
  _AppleDetailsPageState createState() => _AppleDetailsPageState();
}

class _AppleDetailsPageState extends State<AppleDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/apple/applebasic.jpeg',
    'assets/images/apple/appleprocess.jpeg',
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
          'Apple Cultivation Details',
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
          'Apples are a widely cultivated fruit in Pakistan, known for their crisp texture and sweet flavor. They are a vital part of the country\'s horticulture industry, with significant cultivation in the northern and western regions. Apples not only cater to local consumption but also have a growing export market.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Apples play a crucial role in Pakistan\'s agriculture, contributing significantly to the national economy. They provide a substantial income to farmers and workers in the apple supply chain. Additionally, apples are an important source of vitamins and nutrients for the local population, enhancing food security.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'The major apple-growing regions in Pakistan include Balochistan, Khyber Pakhtunkhwa, and parts of Gilgit-Baltistan. These areas offer the ideal climatic conditions needed for apple cultivation. The cool, temperate climates and elevation in these regions support the growth of high-quality apples.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Apples require a temperate climate with a clear distinction between winter and summer seasons for optimal growth. They need chilling periods during the winter to break dormancy and promote flowering. Adequate sunshine during the growing season is crucial for fruit development and sweetness.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Well-drained, loamy soil with a pH between 6.0 and 7.0 is ideal for apple cultivation. The soil should be rich in organic matter to support healthy root development. Proper soil aeration and moisture retention are essential for sustaining apple trees.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Apple Varieties',
          Icons.category,
          'Common varieties of apples grown in Pakistan include Red Delicious, Golden Delicious, and Gala. Each variety has its unique taste, texture, and ripening period, catering to different market demands. These varieties are chosen for their adaptability to local climatic conditions and consumer preferences.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Apple',
          Icons.local_dining,
          'Apples are utilized in various forms, including fresh consumption, juices, jams, and desserts. They are also used in the production of cider and vinegar. The versatility of apples makes them a popular choice in culinary practices and food processing industries.',
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
          'Proper soil preparation involves deep plowing and incorporating organic matter to enhance fertility. Soil testing is conducted to adjust pH levels and nutrient content. Creating raised beds or ridges ensures good drainage, essential for preventing root rot. ',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Selecting high-quality, disease-free seeds or saplings is crucial for successful apple cultivation. Certified nurseries provide grafted saplings of preferred varieties. Choosing the right rootstock and scion ensures compatibility and better growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Apple trees are typically planted as grafted saplings rather than seeds. Proper spacing is maintained to ensure adequate air circulation and sunlight penetration. Saplings are planted during the dormant season, usually in late winter or early spring.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Boll Formation',
          Icons.grain,
          'After flowering, pollinated blossoms develop into fruit. Regular monitoring and care are needed to ensure healthy fruit set. Thinning of excess fruits helps in the proper development of remaining apples, enhancing size and quality.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Picking Preparation',
          Icons.cut,
          'Preparing for harvest involves monitoring fruit maturity and color changes. Nets or other protective measures are used to prevent bird and insect damage. Regular inspections ensure that apples are picked at the optimal time for best flavor and storage quality.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Apples are hand-picked carefully to avoid bruising. Harvesting is done in multiple rounds to ensure all apples are picked at their peak ripeness. Post-harvest handling includes sorting, grading, and storing apples in cool, controlled environments to extend shelf life.',
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
          'Apples require consistent and adequate irrigation, especially during dry periods. Drip irrigation systems are preferred for their efficiency and water conservation. Maintaining soil moisture levels is crucial for preventing stress and promoting healthy growth.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Apple',
          Icons.settings_input_antenna,
          'Regular fertilization with balanced nutrients supports healthy tree growth and fruit production. Organic fertilizers and compost are often used to enrich the soil. Periodic soil testing helps in determining the specific nutrient needs and avoiding deficiencies.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Effective weed control involves mulching, manual weeding, and the use of herbicides if necessary. Mulching not only suppresses weeds but also helps in retaining soil moisture. Keeping the orchard floor clean reduces competition for nutrients and water.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Integrated pest management (IPM) practices are essential for controlling pests and diseases. Regular monitoring and early detection of infestations help in timely intervention. Biological controls, such as beneficial insects, and organic pesticides are preferred to minimize chemical use.',
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
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, color: AppColors.mainColor),
              SizedBox(width: 8.0),
              Text(
                heading,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
