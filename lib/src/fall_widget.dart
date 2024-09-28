import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For asset loading
import 'fall_object.dart';
import 'fall_painter.dart';

class FlutterFall extends StatefulWidget {
  /// The total number of falling objects.
  /// This determines how many particles will be rendered on the screen.
  final int totalObjects;

  /// The speed of falling objects.
  /// A higher value will make the particles fall faster.
  final double speed;

  /// Controls whether the falling effect is active.
  /// When set to true, the particles will be animated.
  final bool isRunning;

  /// If true, the objects will start falling from the top of the screen.
  /// Defaults to fals, allowing particles to enter from the whole screen.
  final bool startFromTop;

  /// List of image URLs or asset paths to be used as falling particles.
  /// This is a required parameter to define the visuals of the falling objects.
  final List<String> particleImage;

  /// The size of each falling particle.
  /// Defaults to 30, but can be adjusted to make particles larger or smaller.
  final double? particleSize;

  /// Speed of rotation for the falling particles.
  /// Defaults to 0.05, which controls how quickly particles spin as they fall.
  final double rotationSpeed;

  /// Speed of the wind effect applied to the falling particles.
  /// Defaults to 1.0, allowing for a gentle sway effect.
  final double windSpeed;

  const FlutterFall({
    super.key,
    this.totalObjects = 40, // Default number of falling objects
    this.speed = 0.05, // Default speed of falling objects
    this.isRunning = true, // Default is to run the animation
    required this.particleImage, // Required list of particle images
    this.startFromTop = false, // Default is to start from the whole screen
    this.particleSize = 30, // Default size of particles
    this.rotationSpeed = 0.02, // Default rotation speed
    this.windSpeed = 1.0, // Default wind speed
  });

  @override
  FallWidgetState createState() => FallWidgetState();
}

class FallWidgetState extends State<FlutterFall>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  double W = 0;
  double H = 0;

  final Random _rnd = Random();
  final List<FallObject> _fallingObjects = [];
  double angle = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      H = MediaQuery.of(context).size.height;
      W = MediaQuery.of(context).size.width;
      _initFallObjects();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = Uint8List.view(data.buffer);
    return await decodeImageFromList(bytes);
  }

  Future<void> _initFallObjects() async {
    for (int i = 0; i < widget.totalObjects; i++) {
      final double density = _rnd.nextDouble() * widget.speed;
      final double x = _rnd.nextDouble() * W;
      final double y =
          widget.startFromTop ? -_rnd.nextDouble() * H : _rnd.nextDouble() * H;

      String imageUrl =
          widget.particleImage[_rnd.nextInt(widget.particleImage.length)];
      ui.Image image = await _loadImage(imageUrl);

      final double size =
          widget.particleSize! * (0.1 + _rnd.nextDouble() * 0.4);
      final double rotation =
          widget.rotationSpeed == 0.0 ? 0.0 : _rnd.nextDouble() * 2 * pi;
      final double wind = widget.windSpeed == 0.0
          ? 0.0
          : (_rnd.nextDouble() * 2 - 1) * widget.windSpeed;

      _fallingObjects.add(
        FallObject(
          x: x,
          y: y,
          size: size,
          density: density,
          image: image,
          rotation: rotation,
          wind: wind,
        ),
      );
    }

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 30))
      ..addListener(() {
        if (mounted) {
          setState(() {
            _updateObjects();
          });
        }
      })
      ..repeat();
  }

  void _updateObjects() {
    angle += 0.01;
    for (FallObject obj in _fallingObjects) {
      obj.y += (cos(angle + obj.density) + obj.size).abs() * widget.speed;
      obj.x += sin(obj.density + obj.wind) * 2 * widget.speed;

      obj.rotation += widget.rotationSpeed;

      if (obj.x > W + obj.size || obj.x < -obj.size || obj.y > H + obj.size) {
        obj.x = _rnd.nextDouble() * W;
        obj.y = -obj.size;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      willChange: widget.isRunning,
      isComplex: true,
      size: Size.infinite,
      painter:
          FallPainter(isRunning: widget.isRunning, objects: _fallingObjects),
    );
  }
}
