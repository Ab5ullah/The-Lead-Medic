import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Adjust width here
        decoration: BoxDecoration(
          color: AppColors.mainColor
              .withOpacity(0.9), // Adjust transparency and color here
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'How We Use It ❓',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.orangeAccent),
                ),
                SizedBox(height: 15),
                _buildStepText(
                  'Step 1: Enter Essential Details 📝',
                  'Begin your journey to farming excellence by providing key information about your farm\'s soil and climate conditions. Input the ratios of Nitrogen (N), Phosphorous (P), and Potassium (K) in your soil, as well as the pH value. Alongside, share vital environmental parameters like the average temperature, relative humidity, and annual rainfall in your region. Rest assured, the more accurate the data, the more tailored and accurate your crop recommendations will be.',
                ),
                SizedBox(height: 10),
                _buildStepText(
                  'Step 2: Unleash the Magic 🌟',
                  'Click "Get Recommendation" to activate advanced algorithms and data analysis.',
                ),
                SizedBox(height: 10),
                _buildStepText(
                  'Step 3: Personalized Crop Suggestions 🌾',
                  'Receive tailored crops backed by data-driven predictions in seconds.',
                ),
                SizedBox(height: 10),
                _buildStepText(
                  'Step 4: Farm with Confidence 🚀',
                  'Optimize yield, reduce risks, and achieve success with precision.',
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepText(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
              fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Custom Dialog')),
      body: Center(
        child: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog(
                context:
                    context, // This context is provided by the Builder widget
                builder: (context) => CustomDialog(),
              );
            },
            child: Text('Show Dialog'),
          ),
        ),
      ),
    ),
  ));
}
