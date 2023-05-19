import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/services/weather.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  void getLocationData() async {
    setState(() => isLoading = true);
    await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    final permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      WeatherModel weatherModel = WeatherModel();
      var weatherData = await weatherModel.getWeatherData();
      setState(() => isLoading = false);

      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }));
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          isLoading ? 'Loading...' : 'No permission to access location',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
