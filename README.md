# fall

A Flutter package to create falling effects using custom images.

## Features

- Create a falling effect using images provided by the user.
- Customizable parameters for speed, size, rotation, and wind effect.

## Getting Started

Add this library to your `pubspec.yaml`:

```yaml
dependencies:
  fall: ^1.0.0
```

Import it where you want to use it:

```dart
import 'package:fall/fall.dart';
```

## Usage

Enclose your widget with FallWidget:

```dart
Scaffold(
  body: FallWidget(
    isRunning: true, // Controls whether the falling effect is active.
    totalObjects: 20, // Number of objects to fall
    speed: 0.05, // Speed of falling objects
    particleImage: ['assets/snowflake.png'], // List of image URLs or asset paths
    particleSize: 20, // Size of the particles
    rotationSpeed: 0.05, // Rotation speed of particles
    windSpeed: 1, // Wind speed for particle movement
  ),
);
```
Optional named arguments:

```dart
    bool isRunning: Controls whether the falling effect is active. Defaults to true.
    int totalObjects: Number of objects to fall. Defaults to 20.
    double speed: Speed of falling objects. Defaults to 0.05.
    List<String> particleImage: List of image URLs or asset paths. Required.
    bool startFromTop: If true, the objects will start falling from the top. Defaults to true.
    double? particleSize: Size of each falling particle. Defaults to 20.
    double rotationSpeed: Speed of rotation for the falling particles. Defaults to 0.05.
    double windSpeed: Speed of the wind effect. Defaults to 1.0.
```

## Additional Information

This project is inspired by [GitHub - Punkachu/SnowingWidget](https://github.com/Punkachu/SnowingWidget). 
