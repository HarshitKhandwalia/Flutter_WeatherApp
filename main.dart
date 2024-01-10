import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(weatherapp());
}

class weatherapp extends StatelessWidget {
  const weatherapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
