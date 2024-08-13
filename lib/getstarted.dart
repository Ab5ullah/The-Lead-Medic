import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class LeafMedicScreen extends StatefulWidget {
  @override
  _LeafMedicScreenState createState() => _LeafMedicScreenState();
}

class _LeafMedicScreenState extends State<LeafMedicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/timberleaf.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                  alignment: Alignment.center,
                  child: Text(
                    'The Leaf Medic',
                    style: GoogleFonts.gruppo(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Cultivating the Green with Excellence',
                    style: GoogleFonts.gruppo(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: InkWell(
                    onTap: () {
                      Get.offNamed('/auth');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.gruppo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(255, 248, 220, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
