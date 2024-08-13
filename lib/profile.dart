import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:the_leaf_medic/folder.dart/About_us.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:the_leaf_medic/folder.dart/app_drawer.dart';
import 'package:the_leaf_medic/folder.dart/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  final _resetPasswordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _uploadingImage = false;
  bool _removingImage = false;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.mainColor,
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.orangeAccent),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  Future<void> _resetPassword() async {
    if (_resetPasswordFormKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );

        await currentUser.sendEmailVerification();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Email Verification'),
            content: Text(
              'A verification email has been sent to your email address.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _emailController.clear();
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Password Reset Failed'),
            content: Text('${e.toString()}'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _uploadingImage = true; // Start uploading state
      });

      File imageFile = File(image.path);
      String fileName = '${currentUser.uid}.jpg';

      try {
        // Upload to Firebase Storage
        UploadTask uploadTask = FirebaseStorage.instance
            .ref('profile_images/$fileName')
            .putFile(imageFile);

        // Track upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          double progress = snapshot.bytesTransferred / snapshot.totalBytes;
          print('Upload progress: $progress');
          // Update UI with progress if needed
        });

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update Firestore with the image URL
        await usersCollection
            .doc(currentUser.email)
            .update({'imageUrl': downloadUrl});
      } catch (e) {
        print('Error uploading image: $e');
      } finally {
        setState(() {
          _uploadingImage = false; // Reset uploading state
        });
      }
    }
  }

  Future<void> _removeImage() async {
    setState(() {
      _removingImage = true; // Set removing state to true
    });

    String fileName = '${currentUser.uid}.jpg';

    try {
      // Remove image from Firebase Storage
      await FirebaseStorage.instance.ref('profile_images/$fileName').delete();

      // Update Firestore to remove the image URL
      await usersCollection
          .doc(currentUser.email)
          .update({'imageUrl': FieldValue.delete()});
    } catch (e) {
      print('Error removing image: $e');
    } finally {
      setState(() {
        _removingImage = false; // Reset removing state
      });
    }
  }

  void _showHelpAndSupportDialog() {
    String query = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.mainColor,
          title: Text(
            'Help and Support',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    query = value;
                  },
                  style: TextStyle(
                    color: Colors.white, // Change the text color here
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your problem or query...',
                    hintStyle: TextStyle(
                        color: Colors
                            .orangeAccent), // Change the hint text color here
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .orangeAccent), // Change the border color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .orange), // Change the border color when focused
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _sendQueryToSupport(query);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange, // Change button background color
                    foregroundColor: Colors.white, // Change button text color
                  ),
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAboutUsDialog() {
    showDialog(
        context: context, // This context is provided by the Builder widget
        builder: (context) => AboutUsDialog());
  }

  void _sendQueryToSupport(String query) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in.');
      return;
    }
    final String username = 'aqsajutt187@gmail.com';
    final String password = 'obdg yrpi rznr yalo';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(user.email!, user.displayName ?? '')
      ..recipients.add('aqsajutt187@gmail.com')
      ..subject = 'User Query'
      ..text = query;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email sent successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error sending email: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending email: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showImageOptions() {
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
                leading: Icon(Icons.delete, color: Colors.white),
                title:
                    Text('Remove Image', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _removeImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.upload_file, color: Colors.white),
                title:
                    Text('Upload Image', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor,
        title: Text(
          "Profile Page",
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: usersCollection.doc(currentUser.email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return Column(children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _uploadingImage || _removingImage
                      ? null
                      : _showImageOptions,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor:
                            Colors.grey[300], // Placeholder background color
                        child: _uploadingImage
                            ? CircularProgressIndicator()
                            : _removingImage
                                ? CircularProgressIndicator()
                                : userData['imageUrl'] != null &&
                                        userData['imageUrl'].isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          userData['imageUrl'],
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(Icons.person,
                                        size: 50,
                                        color:
                                            Colors.white), // Placeholder icon
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add_a_photo,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                MyTextBox(
                  sectionName: 'Username',
                  text: userData['fullName'],
                  onPressed: () => editField('fullName'),
                ),
                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
                ),
                MyTextBox(
                  text: userData['email'],
                  sectionName: 'Email',
                  onPressed: () {
                    // Clear the email controller
                    _emailController.clear();

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.mainColor,
                        title: Text(
                          'Update Email Address',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Form(
                          key: _resetPasswordFormKey,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.orangeAccent),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
                              ).hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_resetPasswordFormKey.currentState!
                                  .validate()) {
                                String newEmail = _emailController.text.trim();

                                // Prompt the user to re-authenticate
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: AppColors.mainColor,
                                    title: Text(
                                      'Re-authenticate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Please re-authenticate to update your email.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Enter your password',
                                            hintStyle: TextStyle(
                                                color: Colors.orangeAccent),
                                          ),
                                          obscureText: true,
                                          controller: _passwordController,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          // Re-authenticate the user
                                          try {
                                            AuthCredential credential =
                                                EmailAuthProvider.credential(
                                              email: currentUser.email!,
                                              password: _passwordController.text
                                                  .trim(),
                                            );

                                            await currentUser
                                                .reauthenticateWithCredential(
                                                    credential);

                                            // After re-authentication, update the email
                                            await currentUser
                                                .verifyBeforeUpdateEmail(
                                                    newEmail);

                                            // Show success message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Verification email sent to $newEmail. Please verify to update.'),
                                                duration: Duration(seconds: 4),
                                              ),
                                            );

                                            // Clear and close dialogs
                                            _passwordController.clear();
                                            _emailController.clear();
                                            Navigator.pop(
                                                context); // Close re-authenticate dialog
                                            Navigator.pop(
                                                context); // Close email update dialog
                                          } catch (e) {
                                            // Show error message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Re-authentication failed: $e'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text('Re-authenticate'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text('Update Email'),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                Divider(
                  thickness: 5,
                  indent: 0.5,
                ),
                //////////////////////////////////////////////
                GestureDetector(
                  onTap: _showHelpAndSupportDialog,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Help and Support",
                                style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          //////////////////////////////////////////////
                          SizedBox(height: 20),
                        ],
                      )),
                )

                /////////////////////////
                ///
                ,
                GestureDetector(
                  onTap: _showAboutUsDialog,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "About Us",
                                style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          //////////////////////////////////////////////
                          SizedBox(height: 20),
                        ],
                      )),
                ),
              ]);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
