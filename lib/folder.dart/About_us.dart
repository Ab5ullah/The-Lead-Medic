import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class AboutUsDialog extends StatelessWidget {
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
                  'About Us',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.orangeAccent),
                ),
                SizedBox(height: 15),
                _buildSectionText(
                  'Overview:',
                  'Leaf Medic is an innovative app designed to help farmers and agricultural enthusiasts detect crop diseases using advanced machine learning techniques. Our app offers a range of functionalities to support modern farming practices.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Mission:',
                  'Our mission is to empower farmers with cutting-edge technology to improve crop health and yield, ensuring sustainable and efficient farming practices.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Vision:',
                  'We envision a world where technology seamlessly integrates with agriculture, leading to healthier crops and more prosperous farming communities.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'History:',
                  'Leaf Medic was founded with the goal of addressing the growing challenges in agriculture, particularly in crop disease management. Leveraging the power of machine learning, we aim to provide a reliable solution for early detection and management of crop diseases.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Products and Services:',
                  '- Crop Disease Detection\n- Maps\n- Reports\n- Profile\n- Marketplace\n- Crop Growth Recommendations\n- Cultivation Guides',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Impact:',
                  'Since our inception, Leaf Medic has helped numerous farmers improve their crop health and yield, making a significant impact in the agricultural sector.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Values:',
                  'We uphold the values of innovation, sustainability, and community support, striving to make a positive difference in the lives of farmers.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Community and Customers:',
                  'Our target audience includes farmers, agricultural professionals, and enthusiasts who seek to leverage technology for better farming outcomes. We engage with our community through regular updates, support, and feedback channels.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Future Plans:',
                  'We are constantly working on expanding our features and services, with exciting projects in the pipeline to further enhance our app’s capabilities.',
                ),
                SizedBox(height: 10),
                _buildSectionText(
                  'Contact Information:',
                  'For support or inquiries, users can reach us at: ',
                ),
                _buildSectionText(
                  'Email:',
                  '"leafmedic.official@gmail.com." ',
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

  Widget _buildSectionText(String title, String description) {
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
