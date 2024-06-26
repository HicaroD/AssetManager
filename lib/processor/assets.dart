import 'processor.dart';

enum ComponentSensorType {
  energy,
  vibration,
}

enum ComponentStatus {
  operating,
  alert,
}

enum AssetType {
  asset,
  component,
}

enum ParentType {
  root,
  location,
  asset,
}

class Assets extends Item {
  final String name;
  final String id;
  final String? locationId;
  final String? parentId;

  final ParentType parentType;

  final AssetType type;

  final ComponentStatus? status;
  final ComponentSensorType? sensorType;

  Assets({
    required this.name,
    required this.id,
    required this.type,
    required this.parentType,
    this.parentId,
    this.locationId,
    this.status,
    this.sensorType,
  });

  factory Assets.fromJson(Map<String, dynamic> json) {
    final name = json["name"] as String;
    final id = json["id"] as String;
    final locationId = json["locationId"] as String?;
    final parentId = json["parentId"] as String?;

    AssetType assetType = AssetType.asset;
    ParentType parentType = ParentType.root;

    ComponentSensorType? sensorType;
    ComponentStatus? status;

    if (json["sensorType"] != null) {
      assetType = AssetType.component;

      sensorType = ComponentSensorType.values.byName(json["sensorType"]!);
      status = ComponentStatus.values.byName(json["status"]!);

      if (locationId != null) {
        parentType = ParentType.location;
      }
      if (parentId != null) {
        parentType = ParentType.asset;
      }
    }

    return Assets(
      name: name,
      id: id,
      locationId: locationId,
      parentId: parentId,
      parentType: parentType,
      type: assetType,
      status: status,
      sensorType: sensorType,
    );
  }
}
