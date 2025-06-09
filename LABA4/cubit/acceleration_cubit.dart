import 'package:flutter_bloc/flutter_bloc.dart';
import 'acceleration_state.dart';

class AccelerationCubit extends Cubit<AccelerationState> {
  AccelerationCubit() : super(AccelerationInitial());

  void calculateAcceleration(
      double initialSpeed, double finalSpeed, double time, bool agreed) {
    if (!agreed) {
      emit(AccelerationError(message: 'Необходимо согласиться на обработку данных'));
      return;
    }

    if (initialSpeed.isNaN || finalSpeed.isNaN || time.isNaN || time <= 0) {
      emit(AccelerationError(message: 'Введите корректные данные'));
      return;
    }

    emit(AccelerationLoading());

    try {
      double acceleration = (finalSpeed - initialSpeed) / time;
      emit(AccelerationResult(
        initialSpeed: initialSpeed,
        finalSpeed: finalSpeed,
        time: time,
        acceleration: acceleration,
      ));
    } catch (e) {
      emit(AccelerationError(message: e.toString()));
    }
  }
}