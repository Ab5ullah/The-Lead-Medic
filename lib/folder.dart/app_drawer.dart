import 'package:flutter/material.dart';
import 'package:the_leaf_medic/Market_Place/MarketplaceScreen.dart';
import 'package:the_leaf_medic/report.dart';
import 'app_colors.dart';
import 'package:the_leaf_medic/cultivation_guide.dart';
import 'package:the_leaf_medic/profile.dart';
import 'package:the_leaf_medic/recommendation.dart';
import 'package:the_leaf_medic/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_leaf_medic/Mappage.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  String? _fullName;
  String? _email;
  String? _profileImageUrl; // Variable to hold profile image URL
  TextEditingController fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _fetchUserData();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _fetchUserData() async {
    try {
      _user = _auth.currentUser!;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_user.email)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        setState(() {
          _fullName = data?['fullName'] ?? 'No Name';
          _email = data?['email'] ?? 'No Email';
          _profileImageUrl = data?['imageUrl']; // Profile image can be null
        });
      } else {
        setState(() {
          _fullName = 'No Name'; // Default name if not found
          _email = 'No Email'; // Default email if not found
          _profileImageUrl =
              null; // Optional: Set to null or handle differently
        });
      }
    } catch (e) {
      print('Error fetching user data: ${e.toString()}');
      // Handle error, optionally set default values or show error message
      setState(() {
        _fullName = 'No Name'; // Set to empty string or handle differently
        _email = 'No Email'; // Set to empty string or handle differently
        _profileImageUrl = null; // Set to null or handle differently
      });
    }
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use BuildContext here
        return AlertDialog(
          title: Text('Sign Out'),
          content: SingleChildScrollView(
            child: Text('Are you sure you want to sign out?'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/getstarted',
                  (route) => false,
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap:
                        _showImageOptions, // Add functionality to change profile picture
                    child: Stack(
                      children: [
                        _buildProfileAvatar(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _fullName ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  _email ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }),
          _buildDrawerItem(Icons.library_books, 'Crops Guide', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CropsPage()),
            );
          }),
          _buildDrawerItem(Icons.eco, 'Smart Grow', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecommendationScreen()),
            );
          }),
          _buildDrawerItem(Icons.account_circle, 'Profile', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }),
          _buildDrawerItem(Icons.shop_2_outlined, 'Market', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MarketplaceScreen()),
            );
          }),

          _buildDrawerItem(Icons.map_outlined, 'Maps', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            );
          }),
          //    _buildDrawerItem(Icons.report, 'Report', () {
          //      Navigator.push(
          //        context,
          //        MaterialPageRoute(builder: (context) => DetectionReportPage()),
          //      );
          //    }),
//

          _buildDrawerItem(Icons.report, 'Report', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetectionReportPage()),
            );
          }),
          _buildDrawerItem(Icons.logout_outlined, 'Logout', () {
            _showSignOutDialog();
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      IconData icon, String title, GestureTapCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      leading: Icon(
        icon,
        size: 30,
        color: AppColors.mainColor,
      ),
      onTap: onTap,
    );
  }

  Widget _buildProfileAvatar() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      backgroundImage: _profileImageUrl != null &&
              Uri.tryParse(_profileImageUrl!)?.isAbsolute == true
          ? NetworkImage(_profileImageUrl!)
          : null,
      child: _profileImageUrl == null ||
              Uri.tryParse(_profileImageUrl!)?.isAbsolute != true
          ? Icon(
              Icons.person_rounded,
              color: AppColors.mainColor,
              size: 60,
            )
          : null,
    );
  }

  void _showImageOptions() {
    // Implement your logic to show image options (upload/remove)
  }
}
