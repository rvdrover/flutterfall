import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For asset loading
import 'fall_controller.dart';
import 'fall_object.dart';
import 'fall_painter.dart';

/// The FlutterFall widget creates a falling particle animation where particles fall across the screen.
class FlutterFall extends StatefulWidget {
  /// The total number of falling particles.
  /// This determines how many particles will be rendered on the screen.
  final int totalParticles;

  /// The speed of falling particles.
  /// A higher value will make the particles fall faster.
  final double particleSpeed;

  /// Controls whether the falling effect is active.
  /// When set to true, the particles will be animated.
  final bool isRunning;

  /// If true, the particles will start falling from the top of the screen.
  /// Defaults to false, allowing particles to enter from the whole screen.
  final bool startFromTop;

  /// List of image URLs or asset paths to be used as falling particles.
  /// This is a required parameter to define the visuals of the falling particles.
  final List<String> particleImages;

  /// The size of each falling particle.
  /// Defaults to 30, but can be adjusted to make particles larger or smaller.
  final double? particleSize;

  /// Speed of rotation for the falling particles.
  /// Defaults to 0.05, which controls how quickly particles spin as they fall.
  final double particleRotationSpeed;

  /// Speed of the wind effect applied to the falling particles.
  /// Defaults to 1.0, allowing for a gentle sway effect.
  final double particleWindSpeed;

  /// Controller for managing dynamic updates.
  /// Allows external control over the falling particle's properties.
  final FallController? fallController;

  const FlutterFall({
    super.key,
    this.totalParticles = 40, // Default number of falling particles
    this.particleSpeed = 0.05, // Default speed of falling particles
    this.isRunning = true, // Default is to run the animation
    required this.particleImages, // Required list of particle images
    this.startFromTop = false, // Default is to start from the whole screen
    this.particleSize = 30, // Default size of particles
    this.particleRotationSpeed = 0.02, // Default rotation speed
    this.particleWindSpeed = 1.0, // Default wind speed
    this.fallController, // Optional controller for external management
  });

  @override
  FallWidgetState createState() => FallWidgetState();
}

/// The state class for the FlutterFall widget.
class FallWidgetState extends State<FlutterFall> with TickerProviderStateMixin {
  late final AnimationController controller;
  late int _totalObjects;
  late double _speed;
  late double _particleSize;
  late double _rotationSpeed;
  late double _windSpeed;

  final List<FallObject> _fallingObjects = []; // List to hold falling particles

  @override
  void initState() {
    super.initState();

    // Initialize values based on the fallController or fallback to widget defaults
    _totalObjects =
        widget.fallController?.totalParticles ?? widget.totalParticles;
    _speed = widget.fallController?.particleFallSpeed ?? widget.particleSpeed;
    _particleSize = widget.fallController?.particleSize ?? widget.particleSize!;
    _rotationSpeed = widget.fallController?.particleRotationSpeed ??
        widget.particleRotationSpeed;
    _windSpeed =
        widget.fallController?.particleWindSpeed ?? widget.particleWindSpeed;

    // Listen for updates to fallController and apply changes dynamically
    widget.fallController?.onUpdate = ({
      int? totalObjects,
      double? speed,
      double? particleSize,
      double? windSpeed,
      double? rotationSpeed,
    }) {
      setState(() {
        if (totalObjects != null) _updateTotalObjects(totalObjects);
        if (speed != null) _speed = speed;
        if (particleSize != null) _updateParticleSize(particleSize);
        if (windSpeed != null) _updateWindSpeed(windSpeed);
        if (rotationSpeed != null) _rotationSpeed = rotationSpeed;
      });
    };

    // Initialize the animation controller for continuous updates (repeats every 30ms)
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30),
    )
      ..addListener(() {
        if (mounted) {
          setState(() {
            _updateObjects(); // Update the position of falling particles on each frame
          });
        }
      })
      ..repeat(); // Continuously repeat the animation

    // After the first frame, initialize the falling objects
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initFallObjects();
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is removed from the widget tree
    controller.dispose();
    super.dispose();
  }

  /// Load an image from the assets or network and return it as a ui.Image.
  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = Uint8List.view(data.buffer);
    return await decodeImageFromList(bytes);
  }

  /// Initialize the falling particles with random positions and sizes.
  Future<void> _initFallObjects() async {
    for (int i = 0; i < _totalObjects; i++) {
      _fallingObjects.add(await _createFallObject());
    }
  }

  /// Create a single falling particle with random properties.
  Future<FallObject> _createFallObject() async {
    final double density = Random().nextDouble() * _speed; // Random speed
    final double x = Random().nextDouble() *
        MediaQuery.of(context).size.width; // Random horizontal position
    final double y = widget.startFromTop
        ? -Random().nextDouble() *
            MediaQuery.of(context).size.height // Start from top if set
        : Random().nextDouble() *
            MediaQuery.of(context).size.height; // Random vertical position

    // Randomly select an image for the particle
    String imageUrl =
        widget.particleImages[Random().nextInt(widget.particleImages.length)];
    ui.Image image = await _loadImage(imageUrl);

    // Randomize particle size, rotation, and wind effect
    final double size = _particleSize * (0.1 + Random().nextDouble() * 0.4);
    final double rotation =
        Random().nextDouble() * 2 * pi; // Random rotation angle
    final double wind = (Random().nextDouble() * 2 - 1) *
        _windSpeed; // Random horizontal movement

    return FallObject(
      x: x,
      y: y,
      size: size,
      density: density,
      image: image,
      rotation: rotation,
      wind: wind,
    );
  }

  /// Dynamically update the total number of falling particles.
  void _updateTotalObjects(int newTotal) async {
    if (newTotal > _fallingObjects.length) {
      for (int i = 0; i < newTotal - _fallingObjects.length; i++) {
        _fallingObjects.add(await _createFallObject());
      }
    } else if (newTotal < _fallingObjects.length) {
      _fallingObjects.removeRange(newTotal, _fallingObjects.length);
    }
    _totalObjects = newTotal;
  }

  /// Dynamically update the size of the falling particles.
  void _updateParticleSize(double newSize) {
    setState(() {
      _particleSize = newSize;
      for (var obj in _fallingObjects) {
        obj.size = newSize * (0.1 + Random().nextDouble() * 0.4);
      }
    });
  }

  /// Dynamically update the wind speed (horizontal movement) of the particles.
  void _updateWindSpeed(double newWindSpeed) {
    setState(() {
      _windSpeed = newWindSpeed;
      for (var obj in _fallingObjects) {
        obj.wind = (Random().nextDouble() * 2 - 1) * _windSpeed;
      }
    });
  }

  /// Update the properties of each falling particle (position, rotation, etc.).
  void _updateObjects() {
    for (FallObject obj in _fallingObjects) {
      obj.y += (cos(obj.density) + obj.size).abs() *
          _speed; // Update vertical position
      obj.x += sin(obj.density + obj.wind) *
          _speed; // Update horizontal position based on wind

      obj.rotation += _rotationSpeed * 0.05; // Apply rotation to the particle
      obj.x += sin(obj.wind) * 0.5; // Apply additional wind effect

      // Reset the position of particles that fall off the screen
      if (obj.x > MediaQuery.of(context).size.width + obj.size ||
          obj.x < -obj.size ||
          obj.y > MediaQuery.of(context).size.height + obj.size) {
        obj.x = Random().nextDouble() * MediaQuery.of(context).size.width;
        obj.y = -obj.size; // Reset Y to top
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Paint the falling particles on the screen using a custom painter
    return CustomPaint(
      willChange: widget.isRunning, // Optimize for when animation is running
      isComplex:
          true, // Declare the custom paint as complex to improve performance
      size: Size.infinite, // Fill the entire available space
      painter: FallPainter(
          isRunning: widget.isRunning,
          particles: _fallingObjects), // Custom painter for particles
    );
  }
}
