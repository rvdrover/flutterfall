# flutterfall

A Flutter package to create falling effects using custom images.

## Features

- Create a falling effect using images provided by the user.
- Customizable parameters for speed, size, rotation, and wind effect.

## Demo

<img width="300" src="https://github.com/rvdrover/fall/blob/39d035b24e13fab6ad4e2e0529351bcd5c777a54/demo.gif"/>

## Getting Started

Add this library to your `pubspec.yaml`:

```yaml
dependencies:
  flutterfall: ^1.0.4
```

Import it where you want to use it:

```dart
import 'package:flutterfall/flutterfall.dart';
```

## Usage

Enclose your widget with FlutterFall:

```dart
Scaffold(
  body: FlutterFall(
    isRunning: true, // Controls whether the falling effect is active.
    totalObjects: 40, // Number of objects to fall
    speed: 0.05, // Speed of falling objects
    particleImage: ['assets/snowflake.png'], // List of image URLs or asset paths
    particleSize: 30, // Size of the particles
    rotationSpeed: 0.02, // Rotation speed of particles
    windSpeed: 1.0, // Wind speed for particle movement
  ),
);
```
Optional named arguments:

```dart
    bool isRunning: Controls whether the falling effect is active. Defaults to true.
    int totalObjects: Number of objects to fall. Defaults to 40.
    double speed: Speed of falling objects. Defaults to 0.05.
    List<String> particleImage: List of image URLs or asset paths. Required.
    bool startFromTop: If true, the objects will start falling from the top. Defaults to false.
    double? particleSize: Size of each falling particle. Defaults to 30.
    double rotationSpeed: Speed of rotation for the falling particles. Defaults to 0.02.
    double windSpeed: Speed of the wind effect. Defaults to 1.0.
```

## Additional Information

This project is inspired by [GitHub - Punkachu/SnowingWidget](https://github.com/Punkachu/SnowingWidget). 
