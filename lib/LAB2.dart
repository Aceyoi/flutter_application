import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Сапожников Юрий ИВТ-22 Вариант 9'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16, // Горизонтальные оступы между контейнерами
      runSpacing: 16, // Вертикальные отступы
      children: [
        buildIconContainer(Icons.home, Colors.blue),
        buildIconContainer(Icons.favorite, Colors.red),
        buildIconContainer(Icons.settings, Colors.green),
        buildIconContainer(Icons.person, Colors.purple),
        buildIconContainer(Icons.email, Colors.orange),
        buildIconContainer(Icons.add, Colors.teal),
      ],
    );
  }

  // Функция для создания контейнера с иконкой
  Widget buildIconContainer(IconData icon, Color color) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.all(8), // Отступы вокруг контейнера
      decoration: BoxDecoration(
        color: color, // Цвет контейнера
        borderRadius: BorderRadius.circular(12), // Закругленные углы
      ),
      child: Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}