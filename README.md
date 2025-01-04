# FlutterFall

A Flutter package to create falling effects using custom images. Customize particle properties like speed, size, rotation, total particles and wind effect, and enjoy smooth dynamic updates.

## Features

- Create a falling effect using images provided by the user.
- Customizable parameters for speed, size, rotation, total particles and wind effect.
- Enhanced performance with dynamic updates using custom controllers.
- Smooth and responsive interactions with debounced property changes.

## Demo

### Static Controller Demo

This example shows a static falling effect with default settings.

![Static Demo](https://github.com/rvdrover/flutterfall/blob/1.0.6/demo_static.gif?raw=true)

### Dynamic Controller Demo

This demo demonstrates dynamic updates using sliders to control particle properties like speed, size, wind effect, rotate effect and total particles.

![Dynamic Demo](https://github.com/rvdrover/flutterfall/blob/1.0.6/demo_dynamic.gif?raw=true)

## Getting Started

Add this library to your `pubspec.yaml`:

```yaml
dependencies:
  flutterfall: ^1.0.6
```

Import it where you want to use it:

```dart
import 'package:flutterfall/flutterfall.dart';
```

## Usage

### Static Setup

Enclose your widget with FlutterFall for a static falling effect:

```dart
Scaffold(
  body: FlutterFall(
    isRunning: true, // Controls whether the falling effect is active.
    totalParticles: 40, // Number of objects to fall
    particleFallSpeed: 0.05, // Speed of falling objects
    particleImages: ['assets/snowflake.png'], // List of image URLs or asset paths
    particleSize: 30, // Size of the particles
    particleRotationSpeed: 0.02, // Rotation speed of particles
    particleWindSpeed: 1.0, // Wind speed for particle movement
  ),
);
```

### Dynamic Controller Setup

For dynamic control over particle properties, use the FallController class. You can dynamically change the total Particles and other properties like speed, size, rotate effect and wind effect using sliders or other UI elements:

```dart
FallController controller = FallController();

Scaffold(
  body: Column(
    children: [
      FlutterFall(
        particleImages: ['assets/snowflake.png'], // List of image URLs or asset paths
        controller: controller, // Attach controller for dynamic updates
      ),
      Slider(
        value: controller.particleFallSpeed,
        min: 0.01,
        max: 1.0,
        onChanged: (value) {
          controller.updateParticleFallSpeed(value);
        },
      ),
      Slider(
        value: controller.totalParticles.toDouble(),
        min: 10,
        max: 100,
        onChanged: (value) {
          controller.updateTotalParticles(value.toInt());
        },
      ),
      Slider(
        value: controller.particleSize,
        min: 10,
        max: 100,
        onChanged: (value) {
          controller.updateParticleSize(value);
        },
      ),
      Slider(
        value: controller.particleWindSpeed,
        min: 0.0,
        max: 5.0,
        onChanged: (value) {
          controller.updateParticleWindSpeed(value);
        },
      ),
      Slider(
        value: controller.particleRotationSpeed,
        min: 0.0,
        max: 1.0,
        onChanged: (value) {
          controller.updateParticleRotationSpeed(value);
        },
      ),
    ],
  ),
);
```

### Controller Overview

The FallController class allows you to update the properties of the falling particles dynamically:

```dart
FallController({
  this.totalParticles = 40,
  this.particleFallSpeed = 0.05,
  this.particleSize = 30.0,
  this.particleRotationSpeed = 0.02,
  this.particleWindSpeed = 1.0,
});
```

### Methods for Updating Properties

- `updateTotalParticles(int newTotal)`  
  Method to update the total number of falling particles.

- `updateParticleFallSpeed(double newSpeed)`  
  Method to update the speed of falling particles.

- `updateParticleSize(double newSize)`  
  Method to update the size of particles.

- `updateParticleWindSpeed(double newWindSpeed)`  
  Method to update the wind speed affecting particles.

- `updateParticleRotationSpeed(double newRotationSpeed)`  
  Method to update the rotation speed of particles.

## Additional Information

This project is inspired by [GitHub - Punkachu/SnowingWidget](https://github.com/Punkachu/SnowingWidget). 