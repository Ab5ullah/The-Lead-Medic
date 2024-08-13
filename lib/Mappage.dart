import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

import 'package:the_leaf_medic/folder.dart/app_drawer.dart';
import 'package:the_leaf_medic/folder.dart/app_colors.dart';
import 'dart:async';

const String GOOGLE_MAPS_API_KEY = 'API';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  bool _isLoading = true;
  double _currentZoom = 14.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showErrorDialog(
            'Location services are not enabled. Please turn on the Location Services');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showErrorDialog('Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showErrorDialog('Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      if (position != null) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _isLoading = false;
        });
        _fetchNearbyFertilizerStores();

        // Animate camera to current position
        final controller = await _controller.future;
        controller.animateCamera(
            CameraUpdate.newLatLngZoom(_currentPosition!, _currentZoom));
      } else {
        _showErrorDialog('Failed to fetch current location. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('Failed to get current location: $e');
    }
  }

  Future<void> _fetchNearbyFertilizerStores() async {
    try {
      if (_currentPosition == null) {
        return;
      }
      final url =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition!.latitude},${_currentPosition!.longitude}&radius=15000&type=store&keyword=fertilizer&key=$GOOGLE_MAPS_API_KEY';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        setState(() {
          _markers = results.map((result) {
            final location = result['geometry']['location'];
            final LatLng latLng = LatLng(location['lat'], location['lng']);

            return Marker(
              markerId: MarkerId(result['place_id']),
              position: latLng,
              infoWindow: InfoWindow(
                title: result['name'],
                snippet: result['vicinity'],
                onTap: () {
                  _showStoreDetails(result);
                },
              ),
            );
          }).toSet();
        });
      } else {
        _showErrorDialog(
            'Failed to load nearby fertilizer stores: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Failed to load nearby fertilizer stores: $e');
    }
  }

  Future<void> _searchCity(String city) async {
    try {
      List<Location> locations = await locationFromAddress(city);
      if (locations.isNotEmpty) {
        LatLng cityLocation =
            LatLng(locations.first.latitude, locations.first.longitude);
        setState(() {
          _currentPosition = cityLocation;
          _isLoading = false;
        });
        final controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newLatLngZoom(cityLocation, 14.0));
        _fetchNearbyFertilizerStores();
      } else {
        _showErrorDialog('No location found for city: $city');
      }
    } catch (e) {
      _showErrorDialog('Failed to fetch location for city: $city. Error: $e');
    }
  }

  void _zoomIn() async {
    setState(() {
      _currentZoom += 1;
    });
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() async {
    setState(() {
      _currentZoom -= 1;
    });
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }

  void _showStoreDetails(dynamic store) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store['name'],
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(store['vicinity']),
              SizedBox(height: 8.0),
              Text('Rating: ${store['rating'] ?? 'N/A'}'),
              SizedBox(height: 8.0),
              Text('Total Ratings: ${store['user_ratings_total'] ?? 'N/A'}'),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Search Nearby Fertilizer Stores',
          style: TextStyle(fontSize: 13),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CitySearchDelegate(_searchCity),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _currentPosition == null
                  ? Center(child: Text('Unable to fetch location'))
                  : GoogleMap(
                      onMapCreated: (controller) {
                        _controller.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: _currentPosition ?? LatLng(0.0, 0.0),
                        zoom: _currentZoom,
                      ),
                      markers: _markers,
                      myLocationEnabled: true,
                    ),
        ],
      ),
    );
  }
}

class CitySearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  CitySearchDelegate(this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.microtask(() {
      onSearch(query);
      close(context, null);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(query),
          onTap: () {
            query = query;
            showResults(context);
          },
        ),
      ],
    );
  }
}
