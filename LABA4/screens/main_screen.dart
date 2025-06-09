import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/acceleration_cubit.dart';
import '../cubit/acceleration_state.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _initialController = TextEditingController();
  final TextEditingController _finalController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор ускорения')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _initialController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Начальная скорость'),
            ),
            TextFormField(
              controller: _finalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Конечная скорость'),
            ),
            TextFormField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Время'),
            ),
            CheckboxListTile(
              title: Text('Согласен на обработку данных'),
              value: _agreed,
              onChanged: (value) {
                setState(() {
                  _agreed = value ?? false;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                double? initial = double.tryParse(_initialController.text);
                double? finalSp = double.tryParse(_finalController.text);
                double? time = double.tryParse(_timeController.text);

                context.read<AccelerationCubit>().calculateAcceleration(
                      initial ?? 0,
                      finalSp ?? 0,
                      time ?? 0,
                      _agreed,
                    );
              },
              child: Text('Рассчитать'),
            ),
            SizedBox(height: 20),
            BlocBuilder<AccelerationCubit, AccelerationState>(
              builder: (context, state) {
                if (state is AccelerationLoading) {
                  return CircularProgressIndicator();
                } else if (state is AccelerationResult) {
                  return Column(
                    children: [
                      Text('Начальная скорость: ${state.initialSpeed} м/с'),
                      Text('Конечная скорость: ${state.finalSpeed} м/с'),
                      Text('Время: ${state.time} с'),
                      Text('Ускорение: ${state.acceleration} м/с²',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  );
                } else if (state is AccelerationError) {
                  return Text(state.message, style: TextStyle(color: Colors.red));
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}