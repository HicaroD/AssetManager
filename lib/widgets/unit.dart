import 'package:flutter/material.dart';

class UnitsPage extends StatelessWidget {
  final String title;

  const UnitsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: go to unit specified unit
        Navigator.pushNamed(context, "/unit");
      },
      child: Container(),
    );
  }
}
