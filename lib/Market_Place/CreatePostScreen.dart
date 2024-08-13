import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:flutter/services.dart'; // Import for TextInputType and TextInputFormatters

final ImagePicker _picker = ImagePicker();

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _cropName = '';
  String _description = '';
  double _price = 0.0;
  String _contactInfo = '';
  List<String> _imageUrls = [];

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      await _uploadImages(images);
    }
  }

  Future<void> _uploadImages(List<XFile> images) async {
    for (XFile image in images) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child(
          'images/${DateTime.now().millisecondsSinceEpoch}-${image.name}');
      await imageRef.putFile(File(image.path));
      final imageUrl = await imageRef.getDownloadURL();
      if (mounted) {
        setState(() {
          _imageUrls.add(imageUrl);
        });
      }
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_imageUrls.isEmpty) {
        // Show error message if no images are uploaded
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please upload at least one image'),
        ));
        return;
      }
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Retrieve additional user details from Firestore
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.email)
            .get();

        if (!userData.exists) {
          // Handle case where user data doesn't exist
          return;
        }

        String fullName = userData.get('fullName');

        // Save post details to Firestore
        await FirebaseFirestore.instance.collection('posts').add({
          'cropName': _cropName,
          'description': _description,
          'price': _price,
          'contactInfo': _contactInfo,
          'imageUrls': _imageUrls,
          'userId': user.uid,
          'fullName': fullName, // Use fullName instead of userName
        });

        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Your crop has been added successfully!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
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

  String? _validatePhoneNumber(String value) {
    // Example of a simple phone number validation using regex
    // Customize this regex according to your specific needs
    Pattern pattern = r'^[0-9]{11}$'; // 11 digits only
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Your Crops'),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Crop Name',
                  filled: true,
                  fillColor: AppColors.forthcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSaved: (value) => _cropName = value!,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
                  fillColor: AppColors.forthcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  filled: true,
                  fillColor: AppColors.forthcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Info (Phone Number)',
                  filled: true,
                  fillColor: AppColors.forthcolor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (value) => _validatePhoneNumber(value!),
                onSaved: (value) => _contactInfo = value!,
              ),
              SizedBox(height: 20),
              _imageUrls.isNotEmpty
                  ? _buildImagePreview()
                  : SizedBox.shrink(), // Show image preview if there are images
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Upload Images'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
