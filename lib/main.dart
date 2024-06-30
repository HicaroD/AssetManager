import 'package:flutter/material.dart';

import 'pages/assets.dart';
import 'pages/home.dart';
import 'utils/colors.dart';

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
        primaryColor: TractianColors.darkBlue,
      ),
      routes: {
        "/": (context) => const HomePage(title: 'Tractian'),
        "/unit": (context) => const AssetsPage(title: 'Assets'),
      },
    );
  }
}
