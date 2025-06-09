import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор ускорения',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/result': (context) => SecondScreen(),
      },
    );
  }
}

// === Первый экран ===
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _initialSpeedController = TextEditingController();
  final TextEditingController _finalSpeedController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('9 вариант — Калькулятор ускорения')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _initialSpeedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Начальная скорость (м/с)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите начальную скорость';
                  if (double.tryParse(value) == null) return 'Введите число';
                  return null;
                },
              ),
              TextFormField(
                controller: _finalSpeedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Конечная скорость (м/с)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите конечную скорость';
                  if (double.tryParse(value) == null) return 'Введите число';
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Время (с)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите время';
                  if (double.tryParse(value) == null) return 'Введите число';
                  if (double.parse(value) <= 0) return 'Время должно быть больше 0';
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Согласен на обработку данных'),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _isChecked) {
                    double initialSpeed = double.parse(_initialSpeedController.text);
                    double finalSpeed = double.parse(_finalSpeedController.text);
                    double time = double.parse(_timeController.text);

                    // Переход на второй экран с передачей данных
                    Navigator.pushNamed(
                      context,
                      '/result',
                      arguments: CalculationArguments(initialSpeed, finalSpeed, time),
                    );
                  } else if (!_isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Необходимо согласиться на обработку данных')),
                    );
                  }
                },
                child: Text('Рассчитать'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// === Класс для передачи данных между экранами ===
class CalculationArguments {
  final double initialSpeed;
  final double finalSpeed;
  final double time;

  CalculationArguments(this.initialSpeed, this.finalSpeed, this.time);
}

// === Второй экран ===
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalculationArguments args = ModalRoute.of(context)!.settings.arguments as CalculationArguments;

    // Расчёт ускорения
    double acceleration = (args.finalSpeed - args.initialSpeed) / args.time;

    return Scaffold(
      appBar: AppBar(title: Text('Результат')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Начальная скорость: ${args.initialSpeed} м/с', style: TextStyle(fontSize: 18)),
            Text('Конечная скорость: ${args.finalSpeed} м/с', style: TextStyle(fontSize: 18)),
            Text('Время: ${args.time} с', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              'Ускорение: $acceleration м/с²',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}