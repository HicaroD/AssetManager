import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'assets.dart';
import 'location.dart';
import 'tree.dart';

abstract class Item {}

// TODO: remove the necessity of having two methods
// They are too similar, we only need one
Future<Map<String, Location>> readLocationJson(String path) async {
  final rawFile = await rootBundle.loadString(path);
  final jsonFile = jsonDecode(rawFile) as List<dynamic>;
  final jsonAsMap = <String, Location>{};
  for (final entry in jsonFile) {
    jsonAsMap[entry["id"]] = Location.fromJson(entry);
  }
  return jsonAsMap;
}

Future<Map<String, Assets>> readAssetsJson(String path) async {
  final rawFile = await rootBundle.loadString(path);
  final jsonFile = jsonDecode(rawFile) as List<dynamic>;
  final jsonAsMap = <String, Assets>{};
  for (final entry in jsonFile) {
    jsonAsMap[entry["id"]] = Assets.fromJson(entry);
  }
  return jsonAsMap;
}

// TODO: get path in the parameter for the selected unit
Future<Tree> getTree() async {
  (Map<String, Location>, Map<String, Assets>) processedData = await (
    readLocationJson("assets/units/apex/locations.json"),
    readAssetsJson("assets/units/apex/assets.json")
  ).wait;

  final tree = Tree();
  tree.generateTree(
    processedData.$1,
    processedData.$2,
  );

  return tree;
}
