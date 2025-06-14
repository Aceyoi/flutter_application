import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/acceleration_cubit.dart';
import 'main_screen.dart';

class MainScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccelerationCubit(),
      child: MainScreen(),
    );
  }
}