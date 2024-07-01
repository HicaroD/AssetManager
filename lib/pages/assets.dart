import 'package:assets/widgets/asset_tree.dart';
import 'package:flutter/material.dart';

import '../tree/tree.dart';
import '../utils/colors.dart';

class AssetsPage extends StatelessWidget {
  final String title;

  const AssetsPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final unitPath = ModalRoute.of(context)?.settings.arguments as String;

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
        future: getTree(unitPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            final error = snapshot.error.toString();
            return Center(child: Text("Error: $error"));
          }
          final tree = snapshot.data!;
          return AssetTree(item: tree.root);
        },
      ),
    );
  }
}
