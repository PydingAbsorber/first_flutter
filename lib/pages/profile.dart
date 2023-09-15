import 'dart:html';

import 'package:first_flutter/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late User user;
  String errorMessage = '';

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Вход успешно выполнен
      print('Пользователь вошел: ${userCredential.user!.uid}');
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(user: userCredential.user!),
        ),
      );
    } catch (e) {
      // Обработка ошибок при входе
      print('Ошибка при входе: $e');
      setState(() {
        errorMessage = 'Ошибка при входе: $e';
      });
    }
  }

  // Метод для регистрации пользователя
  Future<void> register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print('Пользователь зарегистрирован и вошел: ${userCredential.user!.uid}');
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(user: userCredential.user!),
        ),
      );
    } catch (e) {
      // Обработка ошибок при регистрации
      print('Ошибка при регистрации: $e');
      setState(() {
        errorMessage = 'Ошибка при регистрации: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход и Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Цвет кнопки
                onPrimary: Colors.white, // Цвет текста на кнопке
              ),
              child: const Text('Войти'),
            ),
            const SizedBox(height: 10), // Отступ между кнопками
            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Цвет кнопки
                onPrimary: Colors.white, // Цвет текста на кнопке
              ),
              child: const Text('Зарегистрироваться'),
            ),
            const SizedBox(height: 20),
            errorMessage.isNotEmpty ? Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ) : const SizedBox(), // Вывод сообщения об ошибке
          ],
        ),
      ),
    );
  }
}