import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class UpdatePostScreen extends StatefulWidget {
  final QueryDocumentSnapshot post;

  UpdatePostScreen({required this.post});

  @override
  _UpdatePostScreenState createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  TextEditingController _cropNameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _cropNameController.text = widget.post['cropName'];
    _priceController.text = widget.post['price'].toString();
    _contactInfoController.text = widget.post['contactInfo'];
    _descriptionController.text = widget.post['description'];
    _imageUrls = List.from(widget.post['imageUrls']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Crop'),
        backgroundColor: AppColors.mainColor, // Adjust as per your app's design
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _cropNameController,
              decoration: InputDecoration(
                labelText: 'Crop Name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _contactInfoController,
              decoration: InputDecoration(
                labelText: 'Contact Info',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: null, // Allow multiple lines for description
            ),
            SizedBox(height: 24),
            _buildImagePreview(),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _updatePost();
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.mainColor, // Adjust as per your app's design
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    _imageUrls[index],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        _imageUrls.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _updatePost() async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.post.id)
          .update({
        'cropName': _cropNameController.text,
        'price': double.parse(_priceController.text),
        'contactInfo': _contactInfoController.text,
        'description': _descriptionController.text,
        'imageUrls': _imageUrls,
        // Add other fields as needed
      });

      Navigator.pop(context); // Return to MyCropsScreen after update
    } catch (e) {
      print('Error updating post: $e');
      // Handle error if update fails
    }
  }
}
