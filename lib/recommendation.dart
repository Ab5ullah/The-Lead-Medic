import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'package:the_leaf_medic/folder.dart/app_drawer.dart';
import 'package:the_leaf_medic/folder.dart/custom_dialog.dart';

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Define _formKey

  TextEditingController nController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController kController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController phController = TextEditingController();
  TextEditingController rainfallController = TextEditingController();

  String prediction = '';
  @override
  void initState() {
    super.initState();
    // Initialize the controllers here
    nController = TextEditingController();
    pController = TextEditingController();
    kController = TextEditingController();
    temperatureController = TextEditingController();
    humidityController = TextEditingController();
    phController = TextEditingController();
    rainfallController = TextEditingController();
  }

  void _predictCrop() async {
    final String apiUrl = 'http://10.20.6.58:8000/predict';

    Map<String, dynamic> data = {
      'N': double.parse(nController.text),
      'P': double.parse(pController.text),
      'K': double.parse(kController.text),
      'temperature': double.parse(temperatureController.text),
      'humidity': double.parse(humidityController.text),
      'ph': double.parse(phController.text),
      'rainfall': double.parse(rainfallController.text),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      final responseData = json.decode(response.body);
      print(responseData); // Log the response data

      String prediction = responseData['prediction'];

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.mainColor.withOpacity(0.9),
          title: Text(
            'The Recommended Crop according to your provided Values is :',
            style: TextStyle(
                fontSize: 12,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            "'$prediction'",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.orangeAccent),
                textAlign: TextAlign.end,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Smart Grow 🌾',
          style: TextStyle(color: Colors.white),
        ),
        //    leading: IconButton(
        //      icon: Icon(Icons
        //          .arrow_back), // Replace the menu icon with the back arrow icon

        //      onPressed: () {
        //        Navigator.pushReplacement(
        //          context,
        //          MaterialPageRoute(builder: (context) => HomePage()),
        //        );
        //      },
        //      ),
        backgroundColor: AppColors.mainColor,

        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context:
                      context, // This context is provided by the Builder widget
                  builder: (context) => CustomDialog());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(00),
                    // topRight: Radius.circular(00),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/recommendation.png',
                      height: 140,
                      width: 150,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Crop Growing Recommendation',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: nController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nitrogen',
                          hintText: 'Enter the nitrogen value in g/m3 ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final nitrogen = double.tryParse(value);
                          if (nitrogen == null ||
                              nitrogen < 0 ||
                              nitrogen > 200) {
                            return 'Nitrogen value must be between 0-200';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: pController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phosphorus',
                          hintText: 'Enter the phosphorus value in g/m3',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final phosphorus = double.tryParse(value);
                          if (phosphorus == null ||
                              phosphorus < 0 ||
                              phosphorus > 200) {
                            return 'Phosphorus value must be between 0-200';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: kController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Potassium',
                          hintText: 'Enter the potassium value in g/m3 ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final potassium = double.tryParse(value);
                          if (potassium == null ||
                              potassium < 0 ||
                              potassium > 400) {
                            return 'Potassium value must be between 0-400';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: temperatureController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Temperature',
                          hintText: 'Enter the temperature in °C',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final temperature = double.tryParse(value);
                          // Adjust the temperature range according to your needs
                          if (temperature == null ||
                              temperature < 0 ||
                              temperature > 50) {
                            return 'Temperature value must be between 0-50 °C';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: humidityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Humidity',
                          hintText: 'Enter the humidity percentage%',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final humidity = double.tryParse(value);
                          if (humidity == null ||
                              humidity < 0 ||
                              humidity > 100) {
                            return 'Humidity value must be between 0-100';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: phController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'pH Level',
                          hintText: 'Enter the pH level',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final phLevel = double.tryParse(value);
                          if (phLevel == null || phLevel < 0 || phLevel > 14) {
                            return 'pH Level value must be between 0-14';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: rainfallController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Rainfall',
                          hintText: 'Enter the rainfall value in mm',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          final rainfall = double.tryParse(value);
                          // Adjust the rainfall range according to your needs
                          if (rainfall == null ||
                              rainfall < 0 ||
                              rainfall > 2000) {
                            return 'Rainfall value must be between 0-2000';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_validateInputs()) {
                          _predictCrop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                      child: Text('Recommend Crop'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}

void main() {
  runApp(GetMaterialApp(
    home: RecommendationScreen(),
  ));
}



		
//	Rain 	
//	Max	298.5601175
//	Min	20.21126747
//		
//	Nitrogen	
//	Max	140
//	Min	0
//		
//	P	
//	Max	145
//	Min	5
//		
//	K	
//	Max	205
//	Min	5
//		
//		
//	Temp	
//	Max	43.67549305
//	Min	8.825674745
//		
//	Humidity	
//	Max	99.98187601
//	Min	14.25803981
//		
//	Ph	
//	Max	9.93509073
//	Min	3.504752314
//		
//		//
