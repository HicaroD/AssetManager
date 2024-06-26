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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TractianColors.darkBlue,
        centerTitle: true,
        title: Text(title),
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
