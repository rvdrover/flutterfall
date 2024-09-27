import 'dart:ui' as ui;

class FallObject {
  double x;
  double y;
  double size;
  double density;
  ui.Image image;
  double rotation;
  double wind;

  FallObject({
    required this.x,
    required this.y,
    required this.size,
    required this.density,
    required this.image,
    required this.rotation,
    required this.wind,
  });
}
