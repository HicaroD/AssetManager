import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(const AssetManager());
}

class AssetManager extends StatelessWidget {
  const AssetManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Tractian'),
    );
  }
}
