// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/bloc/weather_bloc_bloc.dart';
import 'package:minimal_weather_app/components/my_drawer.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {


  Widget getWeatherIcon(int code){
    switch(code){
      case >=200 && < 300:
       return Lottie.asset('assets/thunderstrom.json');

       case >=300 && < 400:
       return Lottie.asset('assets/rain.json');

       case >=500 && < 600:
       return Lottie.asset('assets/rain.json');

       case >=600 && < 700:
       return Lottie.asset('assets/snow.json');

       case >=700 && < 800:
       return Lottie.asset('assets/pleasentWeather.json');

       case == 800:
       return Lottie.asset('assets/sunny.json');

       case > 800 && <= 804:
       return Lottie.asset('assets/cloud.json');

      default: 
      return  Lottie.asset('assets/pleasentWeather.json');
    
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary, // Dynamic based on theme
  ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer:  MyDrawer(
          
        ),
      
      body: Stack(
        
        children: [
          Padding(padding: EdgeInsetsGeometry.only(right: 20)),

          BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
            builder: (context, state) {
              if(state is WeatherBlocSuccess){
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                     Center(
                      child: Text(
                        '📍 ${state.weather.areaName}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    getWeatherIcon(state.weather.weatherConditionCode!),

                    // Lottie.asset('assets/pleasentWeather.json'),

                    SizedBox(height: 5),

                    Center(
                      child: Text(
                        '${state.weather.temperature!.celsius!.round()}°C',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary  
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        state.weather.weatherMain!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                           color: Theme.of(context).colorScheme.primary  
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    Center(
                      child: Text(
                        DateFormat('EEEE dd').format(state.weather.date!),
                        
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.primary  
                          
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 30),
                            Image.asset('assets/sunrise.png', scale: 8),
                            SizedBox(width: 5),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sunrise',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(height: 3),

                                Text(
                                  DateFormat().add_jm().format(state.weather.sunrise!),
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.primary  ),
                                    
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Image.asset('assets/sunset.png', scale: 8),
                            SizedBox(width: 5),

                            Container(
                              padding: EdgeInsets.only(right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sunset',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(context).colorScheme.secondaryContainer, 
                                    ),
                                  ),
                                  SizedBox(height: 3),

                                  Text(
                                    DateFormat().add_jm().format(state.weather.sunset!),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                       color: Theme.of(context).colorScheme.primary  
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(
                        indent: 20.0, // space from the left
                        endIndent: 20.0, // space from the right
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Image.asset('assets/thermometer.png', scale: 8),
                            SizedBox(width: 5),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Max. Temp',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(height: 3),

                                Text(
                                  '${state.weather.windSpeed}°C',
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                   color: Theme.of(context).colorScheme.primary  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Image.asset('assets/temperature.png', scale: 8),
                            SizedBox(width: 5),

                            Container(
                              padding: EdgeInsets.only(right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Feels Like',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(height: 3),

                                  Text(
                                    '${state.weather.tempFeelsLike!.celsius!.round().toString()}°C',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                       color: Theme.of(context).colorScheme.primary  
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
              }else{
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
