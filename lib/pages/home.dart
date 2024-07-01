import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String get title => widget.title;

  late List<Unit> units;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: TractianColors.white),
        backgroundColor: TractianColors.darkBlue,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: TractianColors.white,
          ),
        ),
      ),
      backgroundColor: TractianColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Go to unit"),
              onPressed: () => Navigator.pushNamed(context, "/unit"),
            ),
          ],
        ),
      ),
    );
  }
}

class Unit {
  final String name;
  final String path;

  Unit(this.name, this.path);

  // TODO: get list of units from units.json on assets folder
  static List<Unit> fromJson(unitPath) {
    return [];
  }
}
