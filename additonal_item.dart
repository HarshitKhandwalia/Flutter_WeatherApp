import 'package:flutter/material.dart';

class additionalwig extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const additionalwig({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             Icon(
              icon,
              size: 30,),
            const SizedBox(
              height: 8,
            ),
             Text(label),
            const SizedBox(
              height: 8,
            ),
            Text(value.toString())
          ],
        ),
      ),
    );
  }
}
