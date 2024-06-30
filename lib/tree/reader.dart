import 'dart:convert';
import 'package:flutter/services.dart';
import 'items.dart';

class Reader {
  final String unitPath;

  Reader({required this.unitPath});

  Future<Map<String, Asset>> readAssets() async {
    final path = "$unitPath/assets.json";
    final rawFile = await rootBundle.loadString(path);
    final jsonFile = jsonDecode(rawFile) as List<dynamic>;
    final jsonAsMap = <String, Asset>{};
    for (final entry in jsonFile) {
      jsonAsMap[entry["id"]] = Asset.fromJson(entry);
    }
    return jsonAsMap;
  }

  Future<Map<String, Location>> readLocations() async {
    final path = "$unitPath/locations.json";
    final rawFile = await rootBundle.loadString(path);
    final jsonFile = jsonDecode(rawFile) as List<dynamic>;
    final jsonAsMap = <String, Location>{};
    for (final entry in jsonFile) {
      jsonAsMap[entry["id"]] = Location.fromJson(entry);
    }
    return jsonAsMap;
  }
}
