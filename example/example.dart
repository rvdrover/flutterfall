import 'package:flutter/material.dart';
import 'package:flutterfall/flutterfall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: const Stack(
            children: [
              Positioned.fill(
                  child: FlutterFall(
                isRunning: true,
                totalObjects: 40,
                speed: 0.05,
                particleImage: ['assets/snowflake.png'],
                particleSize: 30,
                rotationSpeed: 0.02,
                windSpeed: 1.0,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
