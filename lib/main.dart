import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/create_person_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/create': (context) => CreatePersonScreen(),
      },
    );
  }
}
