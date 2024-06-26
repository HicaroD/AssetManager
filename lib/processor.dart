import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class Item {}

class Location extends Item {
  final String name;
  final String? id;
  final String? parentId;

  Location({
    required this.name,
    required this.id,
    this.parentId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final name = json["name"];
    final id = json["id"];
    final parentId = json["parentId"];

    if (json["parentId"] != null) {
      return Sublocation(
        name: name,
        id: id,
        parentId: parentId,
      );
    }
    return Location(
      name: name,
      id: id,
    );
  }
}

class Sublocation extends Location {
  Sublocation({
    required super.name,
    required super.id,
    required super.parentId,
  });
}

enum SensorType {
  energy,
  vibration,
}

enum AssetStatus {
  operating,
  alert,
}

class Asset extends Item {
  final String name;
  final String id;
  final AssetStatus? status;
  final String? locationId;
  final String? parentId;
  final SensorType? sensorType;

  Asset({
    required this.name,
    required this.id,
    this.status,
    required this.locationId,
    required this.parentId,
    this.sensorType,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    final name = json["name"] as String;
    final id = json["id"] as String;
    final locationId = json["locationId"] as String?;
    final parentId = json["parentId"] as String?;

    if (json["sensorType"] != null) {
      final sensorType = SensorType.values.byName(json["sensorType"]!);
      final status = AssetStatus.values.byName(json["status"]!);
      return Component(
        name: name,
        id: id,
        sensorType: sensorType,
        status: status,
        locationId: locationId,
        parentId: parentId,
      );
    }

    return Asset(
      name: name,
      id: id,
      locationId: locationId,
      parentId: parentId,
    );
  }
}

class Component extends Asset {
  Component({
    required super.name,
    required super.id,
    required super.status,
    required super.locationId,
    required super.parentId,
    required SensorType sensorType,
  }) : super(
          sensorType: sensorType,
        );
}

Future<Map<String, Location>> readLocationJson(String path) async {
  final rawFile = await rootBundle.loadString(path);
  final jsonFile = jsonDecode(rawFile) as List<dynamic>;
  final jsonAsMap = <String, Location>{};
  for (final entry in jsonFile) {
    jsonAsMap[entry["id"]] = Location.fromJson(entry);
  }
  return jsonAsMap;
}

Future<Map<String, Asset>> readAssetsJson(String path) async {
  final rawFile = await rootBundle.loadString(path);
  final jsonFile = jsonDecode(rawFile) as List<dynamic>;
  final jsonAsMap = <String, Asset>{};
  for (final entry in jsonFile) {
    jsonAsMap[entry["id"]] = Asset.fromJson(entry);
  }
  return jsonAsMap;
}

class Tree {
  final Map<String, Node> nodes = {};

  void generateTree(
    Map<String, Location> locations,
    Map<String, Asset> assets,
  ) {}
}

class Node {
  final Item item;
  final Map<String, Node> children = {};

  Node({required this.item});
}

// TODO: get path in the parameter for the selected unit
Future<Tree> getTree() async {
  (Map<String, Location>, Map<String, Asset>) processedData = await (
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
