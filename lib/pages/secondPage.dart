import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.title});

  final String title;

  @override
  State<SecondPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SecondPage> {
  double counter = 0;

  void drinkWater(double amount) {
    setState(() {
      DateTime time = DateTime.now();
      if(time.hour == 7 && time.minute == 0 && time.second == 0) {
        counter = 0;
      }
      counter += amount;
    });
  }
  static const TextStyle coolText = TextStyle(
    fontSize: 20,
    color: Colors.blueAccent,
    fontFamily: 'Times New Roman',
  );
  Future<String> getTemperature() async {
    const apiKey = 'de1ca56c50f61136630afa8cdfda568c';
    const city = 'Chisinau';

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final temperature = data['main']['temp'];
      return '$temperature°C'; // Возвращаем температуру в формате "X°C"
    } else {
      throw Exception('Не удалось получить данные о погоде');
    }
  }
  void openMenu(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Menu'),),
        body: Row(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false);
            }, child: const Text('Drink list')),
            const Padding(padding: EdgeInsets.only(left: 15)),
          ],
        ),
      );
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            openMenu();
          }, icon: const Icon(Icons.menu)),
        ],
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Image(
                  image: AssetImage('assets/om.png'),
                  fit: BoxFit.fitWidth,
                  width: 100,
                ),
                const Image(
                  image: AssetImage('assets/water.gif'),
                  fit: BoxFit.fitWidth,
                ),
                Row(
                  children: [
                    Text('Вы выпили сегодня $counter литров воды!'),
                  ],
                ),
                const Row(
                  children: [
                    Text('Так держать!', style: coolText),
                  ],
                ),
                Row(
                  children: [
                    FutureBuilder<String>(
                      future: getTemperature(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Отображаем индикатор загрузки, пока данные загружаются
                        } else if (snapshot.hasError) {
                          return Text('Ошибка: ${snapshot.error}');
                        } else {
                          return Text('Текущая температура: ${snapshot.data}');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ]
      ),
      floatingActionButtonLocation: null, // Убираем автоматическое позиционирование
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 400, // расстояние от нижнего края
            left: 0, // расстояние от левого края
            right: 0, // расстояние от правого края
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onLongPress: () {
                    drinkWater(1);
                  },
                  onPressed: () {
                    drinkWater(0.1);
                  },
                  icon: const Icon(Icons.water),
                  label: const Text('Я попил'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 000, // расстояние от нижнего края
            left: 10, // расстояние от левого края
            right: 0, // расстояние от правого края
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/todo');
                  },
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}