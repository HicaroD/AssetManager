import 'package:assets/widgets/asset_tree.dart';
import 'package:flutter/material.dart';

import '../tree/tree.dart';
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
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: getTree("assets/units/jaguar"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            final error = snapshot.error.toString();
            return Text("Error: $error");
          }
          final tree = snapshot.data!;
          return AssetTree(item: tree.root);
        },
      ),
    );
  }
}
