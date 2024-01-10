import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/secretfile.dart';
import 'additonal_item.dart';
import 'hourly_forcast_item.dart';
import 'package:http/http.dart' as http;
import 'secretfile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _homepagestate();
  }
}

class _homepagestate extends State<HomePage> {
  double temp = 0;
  String tempo = '';
  String label = '1';
  String cityname = 'Delhi';
  
  num humidity = 0;
  num wind_speed = 0;
  String wind_speedF = '';
  num pressure = 0;
  Future getcurrentweather() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityname&APPID=$weatherappapikey'),
      );

      final data = jsonDecode(res.body);
      if (data["cod"] != 200) {
        throw "unkown error occured";
      }

      setState(
        () {
          temp = ((data['main']['temp']) - 273);
          tempo = temp.toStringAsFixed(0);
          label = (data["weather"][0]['description']);
          humidity = (data['main']['humidity']);
          wind_speed = (data['wind']['speed']);
          pressure = (data['main']['pressure']);
          wind_speedF = wind_speed.toString();
          print(wind_speedF);
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrentweather();
  }

  @override
  Widget build(BuildContext context) {
    const textborder =
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                build(context);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 200,
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        cityname = value;
                      });
                      print(cityname);
                      getcurrentweather();
                    },
                    decoration: const InputDecoration(
                        border: textborder,
                        hintText: "City Name",
                        filled: true,
                        fillColor: Color.fromARGB(80, 75, 75, 75)),
                  )),
              const SizedBox(
                height: 30,
              ),
              // main widget
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '$tempo°c',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Icon(
                              label == "rain" ||
                                      label == "cloud" ||
                                      label == "smoke"||
                                      label == "overcast clouds"||
                                      label == "mist"
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 60,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              label,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // second lane
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Weather Forcast",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Hourlyforcast(
                      time: "12:00",
                      icon: Icons.sunny,
                      temp: "30",
                    ),
                    Hourlyforcast(
                      time: "1:00",
                      icon: Icons.sunny,
                      temp: "32",
                    ),
                    Hourlyforcast(
                      time: "2:00",
                      icon: Icons.sunny,
                      temp: "34",
                    ),
                    Hourlyforcast(
                      time: "3:00",
                      icon: Icons.sunny,
                      temp: "35",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Additonal Information",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  additionalwig(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: humidity.toStringAsFixed(0),
                  ),
                  additionalwig(
                    icon: Icons.air,
                    label: "Wind Speed",
                    value: wind_speedF,
                  ),
                  additionalwig(
                    icon: Icons.umbrella,
                    label: "pressure",
                    value: pressure.toStringAsFixed(0),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
