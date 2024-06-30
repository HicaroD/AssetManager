enum ParentType {
  root,
  location,
  asset,
}

abstract class Item {
  final String id;
  final String name;
  final ParentType parentType;
  final String? parentId;
  Map<String, Item> children = {};

  Item(this.id, this.name, this.parentType, this.parentId);

  void addChildren(Item item) {
    // NOTE: I need to update or add, if necessary
    children.update(
      item.id,
      (_) => item,
      ifAbsent: () => item,
    );
  }
}

class Root extends Item {
  Root(super.id, super.name, super.parentType, super.parentId);
}

class Asset extends Item {
  Asset({
    required String id,
    required String name,
    required ParentType parentType,
    required String? parentId,
  }) : super(id, name, parentType, parentId);

  factory Asset.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final name = json["name"];
    final sensorType = json["sensorType"];
    final status = json["status"];

    ParentType parentType = ParentType.root;

    final locationId = json["locationId"];
    final parentId = json["parentId"];

    if (locationId != null) {
      parentType = ParentType.location;
    }
    if (parentId != null) {
      parentType = ParentType.asset;
    }

    if (sensorType != null) {
      final sensorTypeField = ComponentSensorType.values.byName(sensorType);
      final statusField = ComponentStatus.values.byName(status);

      return Component(
        id: id,
        name: name,
        parentType: parentType,
        parentId: parentId ?? locationId,
        status: statusField,
        sensorType: sensorTypeField,
      );
    }

    return Asset(
      id: id,
      name: id,
      parentType: parentType,
      parentId: parentId ?? locationId,
    );
  }
}

enum ComponentSensorType {
  energy,
  vibration,
}

enum ComponentStatus {
  operating,
  alert,
}

class Component extends Asset {
  final ComponentStatus status;
  final ComponentSensorType sensorType;

  Component({
    required super.id,
    required super.name,
    required super.parentType,
    required this.status,
    required this.sensorType,
    required super.parentId,
  });
}

class Location extends Item {
  Location({
    required String id,
    required String name,
    ParentType parentType = ParentType.root,
    required String? parentId,
  }) : super(id, name, parentType, parentId);

  factory Location.fromJson(Map<String, dynamic> json) {
    final name = json["name"];
    final id = json["id"];
    final parentId = json["parentId"];

    if (parentId != null) {
      return Sublocation(
        id: id,
        name: name,
        parentId: parentId,
      );
    }

    return Location(
      name: name,
      id: id,
      parentId: parentId,
    );
  }
}

class Sublocation extends Location {
  Sublocation({
    required super.id,
    required super.name,
    required super.parentId,
    super.parentType = ParentType.location,
  });
}
