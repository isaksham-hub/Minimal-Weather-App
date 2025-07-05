import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minimal_weather_app/bloc/weather_bloc_bloc.dart';
import 'package:minimal_weather_app/pages/weather_page.dart';
// import 'package:minimal_weather_app/themes/dark_theme.dart';
// import 'package:minimal_weather_app/themes/light_theme.dart';
import 'package:minimal_weather_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context)=> ThemeProvider(),
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: FutureBuilder(
        future: _determinePosition(), 
        builder: (context,snap) {
          if(snap.hasData){
             return BlocProvider<WeatherBlocBloc>(
        create: (context) => WeatherBlocBloc()..add(FetchWeather(snap.data as Position)),
        child: const WeatherPage(),
      );
          }
          else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator()
              )
              
            );
                  
          } 
        }
  
        
     
      )
    );
    
  }
}

/// Determine the current position of the device.
    ///
    /// When the location services are not enabled or permissions
    /// are denied the `Future` will return an error.
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
    
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the 
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }
    
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale 
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately. 
        return Future.error(
               'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
