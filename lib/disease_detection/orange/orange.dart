import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:image/image.dart' as img;

import 'package:path_provider/path_provider.dart';

import 'orange_citrus_greening.dart';

class OrangePage extends StatefulWidget {
  @override
  _OrangePageState createState() => _OrangePageState();
}

class _OrangePageState extends State<OrangePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _predictedClass = '';
  double _confidence = 0.0;
  List<File> _images = [];
  final int _maxImages = 3;

  Map<String, String> _diseaseDescriptions = {
    'cotton_aphids':
        'Cotton aphids are tiny insects that suck sap from cotton plants, causing distorted growth and honeydew secretion. Regular monitoring and use of natural enemies or insecticides are recommended for aphid management.',
    'cotton_army_worm':
        'Cotton armyworms are voracious caterpillars that feed on cotton leaves, leading to defoliation. Early detection and use of biological or chemical control measures are important to prevent severe damage.',
    'cotton_bacterial_blight':
        'Cotton bacterial blight is a serious disease that causes water-soaked lesions on cotton leaves and bolls. Management involves use of resistant varieties and sanitation practices.',
    'cotton_healthy':
        'The cotton crop is healthy. However, monitoring for pests and diseases is necessary to prevent potential yield losses.',
    'cotton_powdery_mildew':
        'Cotton powdery mildew is a fungal disease that appears as white powdery growth on leaves. Proper disease management is essential to prevent yield reduction.',
    'cotton_target_spot':
        'Cotton target spot is a fungal disease that causes small, circular lesions on leaves. Fungicide application and good field sanitation practices are important for managing this disease.',
  };

  Future<void> _chooseImage(ImageSource source) async {
    var permissions = await _requestPermissions();
    if (permissions) {
      List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 500,
        imageQuality: 80,
      );

      // ignore: unnecessary_null_comparison
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        List<File> images = [];
        for (var file in pickedFiles) {
          final imageFile = File(file.path);
          images.add(imageFile);
        }

        // Calculate how many more images can be added
        int remainingCapacity = _maxImages - _images.length;
        if (images.length > remainingCapacity) {
          images = images.sublist(
              0, remainingCapacity); // Take only the first N images
        }

        setState(() {
          _images.addAll(images);
          _predictedClass = '';
          _confidence = 0.0;
        });

        // Check if exactly 3 images are selected
        if (_images.length < _maxImages) {
          _showUploadThreeImagesDialog();
        }
      } else {
        _showNoImageSelectedDialog();
      }
    }
  }

  Future<void> _storeDetectionReport(
      String predictedClass, double confidence) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        // Create a new document in 'cropDetectionReports' collection
        await _firestore.collection('cropDetectionReports').add({
          'userId': user.uid, // Associate report with the authenticated user
          'cropType': predictedClass,
          'detectionDate': Timestamp.now(),
          'confidence': confidence,
          // Add other fields as needed
        });

        // Show success message or handle next steps after storing report
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Crop detection report stored successfully')),
        );
      } else {
        print('User is not signed in.');
      }
    } catch (e) {
      // Handle errors if any
      print('Error storing detection report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to store detection report')),
      );
    }
  }

  Future<bool> _requestPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      var permissions = await [
        Permission.camera,
        Permission.storage,
      ].request();
      if (permissions[Permission.camera]?.isDenied == true ||
          permissions[Permission.storage]?.isDenied == true) {
        _showPermissionDeniedDialog();
        return false;
      }
    }
    return true;
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text(
              'Please grant camera and storage permission to use this feature.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadAndPredict() async {
    if (_images.length == _maxImages) {
      final uri = Uri.parse('http://192.168.1.2:8000/predict/orange');
      List<http.MultipartFile> files = [];
      for (var image in _images) {
        // Resize image to (224, 224)
        File resizedImage = await _resizeImage(image);
        files
            .add(await http.MultipartFile.fromPath('files', resizedImage.path));
      }
      final request = http.MultipartRequest('POST', uri);
      request.files.addAll(files);

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          final responseJson = await response.stream.bytesToString();
          final data = json.decode(responseJson);

          setState(() {
            _predictedClass = _formatClassName(data['class'] ?? '');
            _confidence = data['confidence'] ??
                0.0; // Ensure confidence is correctly parsed
          });

          // Store detection report in Firestore
          await _storeDetectionReport(_predictedClass, _confidence);
        } else {
          print('HTTP Error: ${response.statusCode}');
          print(await response.stream.bytesToString());
          // Handle HTTP errors
          _showErrorDialog('Error ${response.statusCode}',
              'Failed to predict. Please try again later.');
        }
      } catch (e) {
        print('Network Error: $e');
        // Handle network errors
        _showErrorDialog('Network Error',
            'Failed to connect to the server. Please check your internet connection and try again.');
      }
    }
  }

  Future<File> _resizeImage(File image) async {
    try {
      img.Image? rawImage = img.decodeImage(image.readAsBytesSync());
      if (rawImage == null) {
        throw Exception("Failed to decode image");
      }

      // Resize image
      img.Image resizedImage =
          img.copyResize(rawImage, width: 224, height: 224);

      // Save resized image to temporary file
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final String fileName = image.path.split('/').last;
      final File resizedFile = File('$tempPath/$fileName');
      await resizedFile.writeAsBytes(img.encodePng(resizedImage));

      return resizedFile;
    } catch (e) {
      print("Error resizing image: $e");
      throw Exception("Failed to resize image");
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUploadThreeImagesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload 3 Images'),
          content: Text('Please upload  3 images to for better results.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInstructionsPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.mainColor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '🌾  Instructions 🌾 ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Tips for accurate results:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tips.length,
                    itemBuilder: (BuildContext context, int index) {
                      final tip = tips[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ',
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                            Expanded(
                                child: Text(
                              tip,
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showNoImageSelectedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Image Selected'),
          content: Text('Please select an image before uploading.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatClassName(String className) {
    String formattedName = className.replaceAll('_', ' ');
    return formattedName
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  final List<String> tips = [
    'Capture a clear image of the Orange leaf.',
    'Avoid blurry or low-quality images.',
    'Use the camera button to take a photo.',
    'Choose an image from the gallery using the gallery button.',
    'Press the DETECT button to start the analysis.',
  ];

  void _showInfoPrompt() {
    final formattedClassName =
        _predictedClass.toLowerCase().replaceAll(' ', '_');
    final description = _diseaseDescriptions[formattedClassName];
    final diseaseName = _formatClassName(formattedClassName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    diseaseName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    description ?? 'No description available for this disease',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 74, 181, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPrecautions() {
    final formattedClassName =
        _predictedClass.toLowerCase().replaceAll(' ', '_');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _getDiseasePage(formattedClassName),
      ),
    );
  }

  Widget _getDiseasePage(String formattedClassName) {
    switch (formattedClassName) {
      case 'orange_citrus_greening':
        return OrangeCirtusGreeningPage();

      default:
        return Container(); // Return an empty container for unknown cases
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInstructionsPrompt();
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Orange Disease Detection',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: _showInstructionsPrompt,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              dashPattern: [6, 3],
              color: Colors.orangeAccent,
              strokeWidth: 2,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _images.isEmpty
                    ? Center(
                        child: Text(
                          'No image selected',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              _images[index],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //     ElevatedButton.icon(
                //       icon: Icon(Icons.photo_camera),
                //       label: Text(''),
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: AppColors.mainColor,
                //         foregroundColor: Colors.white,
                //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                //         textStyle: TextStyle(
                //           fontSize: 10,
                //         ),
                //       ),
                //       onPressed: () => _chooseImage(ImageSource.camera),
                //     ),
                Row(
                  children: [
                    Container(
                      width: buttonWidth,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.upload),
                        label: Text('Upload Your Crop Image to Detect Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          textStyle: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        onPressed: () => _showImageOptions(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: buttonWidth,
                  child: ElevatedButton(
                      onPressed: _uploadAndPredict,
                      child: Text(
                        'Detect',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
            _predictedClass.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Prediction: $_predictedClass',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Confidence: ${(_confidence * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: _showInfoPrompt,
                                icon: Icon(Icons.info_outline),
                                label: Text(
                                  'View Info',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mainColor,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: _showPrecautions,
                                icon: Icon(Icons.warning_amber_rounded),
                                label: Text('Precautions'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.orangeAccent,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _showImageOptions() {
    int imagesSelected = 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(24, 43, 50, 0.7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.white),
                title: Text('Choose Image From Gallery',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _chooseImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      // After closing the modal, check if three images are selected
      if (imagesSelected == 3) {
        // Show some confirmation or proceed with detection
        _uploadAndPredict(); // Example: Directly proceed to detection
      }
    });
  }
}
