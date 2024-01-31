import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'second_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Location location = Location();
  LocationData? currentLocation; // Use nullable type

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      currentLocation = await location.getLocation();
      setState(() {});
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              child: Text('Go to Second Screen'),
            ),
            SizedBox(height: 20),
            Text(
              'Current Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (currentLocation != null)
              Text(
                'Latitude: ${currentLocation!.latitude}\nLongitude: ${currentLocation!.longitude}',
                style: TextStyle(fontSize: 16),
              )
            else
              Text('Location not available'),
          ],
        ),
      ),
    );
  }
}
