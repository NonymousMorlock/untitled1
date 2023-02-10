import 'package:flutter/material.dart';
import 'package:untitled1/services/networking.dart';
import '../services/location.dart';
import 'location_screen.dart';

const apiKey = '593eaf50f10204624eadfa46134717e3';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap'
        '.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationWeather: weatherData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          "https://w.wallhaven.cc/full/4y/wallhaven-4y37g0.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              getLocationData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              elevation: (10),
            ),
            child: const Text('Get Location'),
          ),
        ),
      ],
    );
  }
}
