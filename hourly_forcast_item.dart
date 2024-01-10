import 'package:flutter/material.dart';

class Hourlyforcast extends StatelessWidget {
  final String time;
    final IconData icon;
    final String temp;
  const Hourlyforcast({super.key, required this.time, required this.icon, required this.temp,});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        child: SizedBox(
          child: Padding(
            padding:const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(time),
                const SizedBox(
                  height: 8,
                ),
                Icon(icon),
                const SizedBox(
                  height: 8,
                ),
                Text(temp)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
