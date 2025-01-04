/// `FallController` is a class that manages the behavior and properties of falling particles in a Flutter application.
/// It allows external management of particle characteristics like speed, size, rotation, and wind speed.
/// The controller can notify listeners (callback) whenever a property is updated.
class FallController {
  // The total number of falling particles to render.
  int totalParticles;

  // The speed at which the particles fall. A higher value makes the particles fall faster.
  double particleFallSpeed;

  // The size of each falling particle.
  double particleSize;

  // The speed at which the particles rotate while falling.
  double particleRotationSpeed;

  // The wind speed that affects the horizontal movement of particles.
  double particleWindSpeed;

  // Private variable that holds the callback function for property updates.
  // This callback is called when any property is changed.
  Function({
    int? totalObjects,
    double? speed,
    double? particleSize,
    double? windSpeed,
    double? rotationSpeed,
  })? _onUpdate;

  /// The constructor for `FallController`. It allows you to initialize the controller with custom values or defaults.
  ///
  /// [totalParticles] determines how many particles will fall.
  /// [particleFallSpeed] controls how fast the particles fall.
  /// [particleSize] defines the size of the particles.
  /// [particleRotationSpeed] controls how fast the particles rotate while falling.
  /// [particleWindSpeed] controls how the wind affects the horizontal movement of the particles.
  FallController({
    this.totalParticles = 40, // Default total particles
    this.particleFallSpeed = 0.05, // Default fall speed
    this.particleSize = 30.0, // Default particle size
    this.particleRotationSpeed = 0.02, // Default rotation speed
    this.particleWindSpeed = 1.0, // Default wind speed
  });

  /// A private method that notifies the assigned callback function of any updates to the particle properties.
  ///
  /// This method is called when any of the properties like `totalParticles`, `particleFallSpeed`, etc., are changed.
  void _notifyUpdate({
    int? totalObjects,
    double? speed,
    double? particleSize,
    double? windSpeed,
    double? rotationSpeed,
  }) {
    // If an `onUpdate` callback is set, call it with the updated values.
    if (_onUpdate != null) {
      _onUpdate!(
        totalObjects: totalObjects,
        speed: speed,
        particleSize: particleSize,
        windSpeed: windSpeed,
        rotationSpeed: rotationSpeed,
      );
    }
  }

  /// Updates the total number of falling particles.
  ///
  /// This method sets the [totalParticles] to the new value and triggers the callback to notify the change.
  void updateTotalParticles(int newTotal) {
    totalParticles = newTotal; // Set the new total number of particles
    _notifyUpdate(
        totalObjects: totalParticles); // Notify any listeners of the update
  }

  /// Updates the speed at which particles fall.
  ///
  /// This method sets the [particleFallSpeed] to the new value and triggers the callback to notify the change.
  void updateParticleFallSpeed(double newSpeed) {
    particleFallSpeed = newSpeed; // Set the new fall speed for particles
    _notifyUpdate(
        speed: particleFallSpeed); // Notify any listeners of the update
  }

  /// Updates the size of the falling particles.
  ///
  /// This method sets the [particleSize] to the new value and triggers the callback to notify the change.
  void updateParticleSize(double newSize) {
    particleSize = newSize; // Set the new size for particles
    _notifyUpdate(
        particleSize: particleSize); // Notify any listeners of the update
  }

  /// Updates the wind speed that affects the particles' horizontal movement.
  ///
  /// This method sets the [particleWindSpeed] to the new value and triggers the callback to notify the change.
  void updateParticleWindSpeed(double newWindSpeed) {
    particleWindSpeed = newWindSpeed; // Set the new wind speed
    _notifyUpdate(
        windSpeed: particleWindSpeed); // Notify any listeners of the update
  }

  /// Updates the rotation speed of the particles.
  ///
  /// This method sets the [particleRotationSpeed] to the new value and triggers the callback to notify the change.
  void updateParticleRotationSpeed(double newRotationSpeed) {
    particleRotationSpeed =
        newRotationSpeed; // Set the new rotation speed for particles
    _notifyUpdate(
        rotationSpeed:
            particleRotationSpeed); // Notify any listeners of the update
  }

  /// The setter for the `onUpdate` callback function. This setter allows the developer to assign a callback function
  /// that will be called whenever one of the properties is updated.
  ///
  /// The callback function can handle changes to properties like the total number of particles, speed, size, etc.
  set onUpdate(
      Function({
        int? totalObjects,
        double? speed,
        double? particleSize,
        double? windSpeed,
        double? rotationSpeed,
      })? callback) {
    _onUpdate =
        callback; // Assign the provided callback to the `_onUpdate` variable
  }
}
