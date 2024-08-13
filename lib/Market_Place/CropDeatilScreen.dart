import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class CropDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot post;

  CropDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          post['cropName'] ?? 'Crop Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              child: post['imageUrls'] != null &&
                      (post['imageUrls'] as List).isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (post['imageUrls'] as List).length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            post['imageUrls'][index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 48,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No images available',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['cropName'] ?? 'Crop Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: AppColors.mainColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    post['description'] ?? 'No description available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Price: ${post['price'] ?? 'Price not specified'}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Contact: ${post['contactInfo'] ?? 'Contact information not available'}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Seller: ${post['fullName'] ?? 'Seller information not available'}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
