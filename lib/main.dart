import 'package:flutter/material.dart';
import 'package:toon_practice/screens/home_screen.dart';
import 'package:toon_practice/services/api_service.dart';

void main() {
  ApiService().getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
