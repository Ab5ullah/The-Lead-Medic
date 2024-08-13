import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_leaf_medic/Market_Place/CreatePostScreen.dart';
import 'package:the_leaf_medic/Market_Place/CropDeatilScreen.dart';
import 'package:the_leaf_medic/Market_Place/My_Crops.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class MarketplaceScreen extends StatefulWidget {
  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Marketplace',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            color: AppColors.mainColor.withOpacity(0.9),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'addCrops',
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.orangeAccent),
                    SizedBox(width: 10),
                    Text('Add Crops',
                        style: TextStyle(color: Colors.orangeAccent)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'myCrops',
                child: Row(
                  children: [
                    Icon(Icons.list, color: Colors.orangeAccent),
                    SizedBox(width: 10),
                    Text('My Crops',
                        style: TextStyle(color: Colors.orangeAccent)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'addCrops') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
              } else if (value == 'myCrops') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCropsScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: currentUser != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search crops...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query.toLowerCase();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No posts available'));
                      }

                      final posts = snapshot.data!.docs.where((post) {
                        final cropName =
                            (post['cropName'] as String).toLowerCase();
                        return cropName.contains(searchQuery);
                      }).toList();

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 5,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          final isOwner = post['userId'] == currentUser.uid;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CropDetailScreen(post: post),
                                ),
                              );
                            },
                            child: Card(
                              color: AppColors.mainColor,
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                (post['imageUrls'] as List)
                                                    .length,
                                            itemBuilder: (context, imageIndex) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Image.network(
                                                  post['imageUrls'][imageIndex],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
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
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post['cropName'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Price: ${post['price']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Contact: ${post['contactInfo']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Seller: ${post['fullName']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isOwner)
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.white),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('posts')
                                              .doc(post.id)
                                              .delete();
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'User not logged in',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
