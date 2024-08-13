import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';

class DetectionReportPage extends StatefulWidget {
  @override
  _DetectionReportPageState createState() => _DetectionReportPageState();
}

class _DetectionReportPageState extends State<DetectionReportPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _selectedCrop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        title: Text('Detection Reports'),
      ),
      body: Column(
        children: [
          _buildCropDropdown(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDetectionReports(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('cropDetectionReports')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;
        Set<String> cropNamesSet = Set<String>();

        documents.forEach((doc) {
          // Assuming 'cropType' contains disease names like 'Corn Blight'
          String diseaseName = doc['cropType'] as String;
          // Extracting the crop name, assuming the format is '<Crop> <Disease>'
          List<String> parts = diseaseName.split(' ');
          if (parts.isNotEmpty) {
            cropNamesSet.add(parts.first);
          }
        });

        List<String> cropNames = cropNamesSet.toList()..sort();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36.0,
              elevation: 16,
              style: TextStyle(color: Colors.black87, fontSize: 18.0),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              value: _selectedCrop,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCrop = newValue!;
                });
              },
              items: cropNames.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetectionReports() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Center(child: Text('User not authenticated.'));
    }

    Query query = _firestore
        .collection('cropDetectionReports')
        .where('userId', isEqualTo: currentUser.uid);

    if (_selectedCrop != null) {
      // Filter based on first word of cropType
      String selectedPrefix = _selectedCrop!.trim();
      String nextPrefix = String.fromCharCode(selectedPrefix.codeUnitAt(0) + 1);

      query = query
          .where('cropType', isGreaterThanOrEqualTo: selectedPrefix)
          .where('cropType', isLessThan: nextPrefix);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No detection reports available.'));
        }

        List<DocumentSnapshot> reports = snapshot.data!.docs;
        List<CropReport> data =
            reports.map((report) => CropReport.fromSnapshot(report)).toList();

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _buildReportCard(data[index]);
          },
        );
      },
    );
  }

  Widget _buildReportCard(CropReport report) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.cropType,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Confidence: ${(report.confidence * 100).toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Detected on: ${_formatDateTime(report.timestamp)}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  interval: 10,
                  minimum: 10,
                  maximum: 100,
                  labelFormat: '{value}%', // Optional: Formats the axis labels
                ),
                series: <CartesianSeries>[
                  BarSeries<CropReport, String>(
                    dataSource: [report],
                    xValueMapper: (CropReport report, _) => report.cropType,
                    yValueMapper: (CropReport report, _) =>
                        report.confidence * 100,
                    color: _getColorForCrop(report.cropType),
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
  }

  Color _getColorForCrop(String cropType) {
    // Extract prefix (first word)
    String prefix = cropType.split(' ').first.toLowerCase();

    // Generate color based on prefix
    switch (prefix) {
      case 'corn':
        return Colors.yellow;
      case 'cotton':
        return Colors.grey;
      case 'rice':
        return Colors.amber;
      case 'sugarcane':
        return Colors.pink;
      case 'wheat':
        return Colors.blue;
      case 'apple':
        return Colors.red;
      case 'grape':
        return Colors.purple;
      case 'pepper':
        return Colors.green;
      case 'potato':
        return Colors.brown;
      case 'cherry':
        return Colors.deepOrange;
      case 'tomato':
        return Colors.green;
      // Default case
      default:
        return Colors.orange;
    }
  }
}

class CropReport {
  final String cropType;
  final double confidence;
  final DateTime timestamp;

  CropReport(this.cropType, this.confidence, this.timestamp);

  factory CropReport.fromSnapshot(DocumentSnapshot snapshot) {
    return CropReport(
      snapshot['cropType'],
      (snapshot['confidence'] ?? 0),
      (snapshot['detectionDate'] as Timestamp).toDate(),
    );
  }
}
