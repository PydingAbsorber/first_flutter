import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Метод для выхода из профиля
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.currentUser!.reload();
      Navigator.of(context).pop();
    } catch (e) {
      print('Ошибка при выходе: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Почта: ${widget.user.email}'),
            Text('Дата регистрации: ${widget.user.metadata.creationTime}'),
            const Text('Счёт: 0'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                signOut,
                Navigator.pop(context),
                Navigator.pushNamed(context, '/shop'),
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
