
abstract class AccelerationState {}

class AccelerationInitial implements AccelerationState {}

class AccelerationLoading implements AccelerationState {}

class AccelerationResult implements AccelerationState {
  final double initialSpeed;
  final double finalSpeed;
  final double time;
  final double acceleration;

  AccelerationResult({
    required this.initialSpeed,
    required this.finalSpeed,
    required this.time,
    required this.acceleration,
  });
}

class AccelerationError implements AccelerationState {
  final String message;

  AccelerationError({required this.message});
}