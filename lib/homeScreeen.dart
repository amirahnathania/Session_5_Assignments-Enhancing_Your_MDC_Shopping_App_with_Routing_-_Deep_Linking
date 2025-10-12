import 'package:flutter/material.dart';
import 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reuse existing HomePage from home.dart
    return const HomePage();
  }
}