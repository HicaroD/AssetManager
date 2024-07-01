import 'dart:convert';

import 'package:flutter/services.dart';

import 'items.dart';
import 'reader.dart';

class Tree {
  final Item root = Root(
    "",
    "root",
    ItemType.root,
    ParentType.root,
    "",
  );

  final Map<String, Asset> assets;
  final Map<String, Location> locations;

  Tree({
    required this.assets,
    required this.locations,
  });

  void build() {
    for (final asset in assets.values) {
      final analyzedItem = getItem(asset);
      root.addChildren(analyzedItem);
    }
  }

  Item getItem(Item item) {
    switch (item.parentType) {
      case ParentType.root:
        assert(item.parentId == null);
        return item;
      case ParentType.location:
        final parentLocation = locations[item.parentId]!;
        parentLocation.addChildren(item);
        return getItem(parentLocation);
      case ParentType.asset:
        final parentAsset = assets[item.parentId]!;
        parentAsset.addChildren(item);
        return getItem(parentAsset);
    }
  }
}

class Unit {
  final String name;
  final String path;

  Unit(this.name, this.path);

  static List<Unit> fromJson(Map<String, dynamic> units) {
    return (units["units"] as List<dynamic>)
        .map((unit) => Unit(unit["name"], unit["path"]))
        .toList();
  }
}

Future<List<Unit>> readUnits() async {
  final unitsFile = await rootBundle.loadString("assets/units.json");
  final unitsJson = jsonDecode(unitsFile);
  final units = Unit.fromJson(unitsJson);
  return units;
}

Future<Tree> getTree(String unitPath) async {
  final reader = Reader(unitPath: unitPath);
  final data = await Future.wait([
    reader.readAssets(),
    reader.readLocations(),
  ]);

  final tree = Tree(
    assets: data[0] as Map<String, Asset>,
    locations: data[1] as Map<String, Location>,
  );
  tree.build();
  return tree;
}
