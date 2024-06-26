import 'package:flutter/material.dart';

import '../processor/processor.dart';
import '../utils/colors.dart';

class AssetsPage extends StatefulWidget {
  final String title;

  const AssetsPage({
    super.key,
    required this.title,
  });

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  String get title => widget.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TractianColors.darkBlue,
        centerTitle: true,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: getTree(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  final error = snapshot.error.toString();
                  return Text("Error: $error");
                }

                final tree = snapshot.data!.root;
                // TODO: return tree widget
                return const Text("Loaded successfuly");
              },
            ),
          ],
        ),
      ),
    );
  }
}
