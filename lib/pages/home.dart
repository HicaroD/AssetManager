import 'package:flutter/material.dart';

import '../tree/tree.dart';
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
        child: FutureBuilder(
          future: readUnits(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            final units = snapshot.data!;
            return ListView.builder(
              itemCount: units.length,
              itemBuilder: (context, index) {
                final unit = units[index];
                return ElevatedButton(
                  child: Text(unit.name),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    "/assets",
                    arguments: unit.path,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
