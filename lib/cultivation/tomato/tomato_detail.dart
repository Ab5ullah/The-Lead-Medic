import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class TomatoDetailsPage extends StatefulWidget {
  @override
  _TomatoDetailsPageState createState() => _TomatoDetailsPageState();
}

class _TomatoDetailsPageState extends State<TomatoDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _selectedTab = 0;

  final List<String> tabTitles = ['Basic Info', 'Process', 'Care'];
  final List<String> tabImages = [
    'assets/images/tomato/tomatobasic.jpeg',
    'assets/images/tomato/tomatoprocess.jpeg',
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
          'Tomato Cultivation Details',
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
          'Tomato is a widely cultivated vegetable known for its culinary versatility and nutritional benefits. It is a staple ingredient in many cuisines around the world.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Importance',
          Icons.stars,
          'Tomato production contributes significantly to global agricultural economies. It is valued for its role in fresh consumption, food processing, and as a source of essential nutrients.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Growing Regions',
          Icons.landscape,
          'Tomatoes are cultivated in various regions of Pakistan, with significant production centers in Punjab, Sindh, Khyber Pakhtunkhwa (KP), and Balochistan provinces. These regions provide favorable agro-climatic conditions suitable for tomato cultivation.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Climate',
          Icons.wb_sunny,
          'Tomatoes thrive in warm climates with temperatures ranging from 15°C to 30°C (59°F to 86°F). They require well-drained soils and adequate sunlight for optimal growth and fruit development, which are typically found in the plains and lowland areas of these provinces.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Soil Requirements',
          Icons.checklist,
          'Tomatoes prefer fertile, loamy soils with a pH level between 6.0 to 7.0. Soil should be rich in organic matter to support healthy plant growth and fruit development.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Tomato Varieties',
          Icons.category,
          'There are numerous tomato cultivars with varying sizes, shapes, and flavors. Varieties range from small cherry tomatoes to large beefsteak types, each suited to different culinary uses.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Utilization of Tomato',
          Icons.local_dining,
          'Tomatoes are consumed fresh, cooked, or processed into sauces, soups, juices, and ketchup. They are rich in vitamins, minerals, and antioxidants, promoting health benefits.',
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
          'Prepare planting beds by incorporating organic matter and ensuring good drainage. Tomato plants thrive in well-prepared soil that promotes strong root development.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Seed Selection',
          Icons.eco,
          'Select tomato seeds based on desired traits such as flavor, disease resistance, and fruit size. Start seeds indoors in trays or pots before transplanting them into the garden.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Sowing',
          Icons.spa,
          'Transplant tomato seedlings outdoors after the last frost date. Space plants according to their mature size, providing adequate room for air circulation and sunlight exposure.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Boll Formation',
          Icons.grain,
          'During tomato plant growth, boll formation refers to the development of fruiting bodies where flowers transform into tomatoes. This stage requires adequate nutrients, especially potassium and phosphorus, to support fruit development. Farmers monitor plant health and ensure consistent watering to promote healthy boll formation.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Picking Preparation',
          Icons.cut,
          'Before harvesting tomatoes, farmers prepare the fields by pruning and removing unnecessary foliage. This practice helps improve air circulation and sunlight exposure to ripen the fruits uniformly. Additionally, farmers organize harvesting equipment and labor to ensure efficient and timely picking of mature tomatoes.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Harvesting',
          Icons.nature,
          'Harvest tomatoes when they reach mature color and firmness. Gently twist or cut fruits from the vine to avoid damaging plants. Store tomatoes at room temperature for optimal flavor.',
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
          'Tomatoes require regular watering to maintain consistent soil moisture. Use drip irrigation or soaker hoses to deliver water directly to the root zone, minimizing foliage wetting.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Fertilization for Cotton',
          Icons.settings_input_antenna,
          'Feed tomatoes with a balanced fertilizer rich in nitrogen, phosphorus, and potassium. Apply fertilizer according to plant growth stages, avoiding excessive nitrogen which can reduce fruit quality.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Weed Control',
          Icons.grass,
          'Control weeds around tomato plants to prevent competition for nutrients and water. Mulch with straw or organic material to suppress weeds and maintain soil moisture.',
        ),
        SizedBox(height: 16.0),
        _buildContainerWithIcon(
          'Pest Management',
          Icons.bug_report,
          'Monitor tomato plants for pests such as aphids, hornworms, and tomato fruitworms. Use insecticidal soap or biological controls to manage pest infestations while minimizing environmental impact.',
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
    home: TomatoDetailsPage(),
  ));
}
