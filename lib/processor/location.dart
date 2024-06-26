import 'processor.dart';

class Location extends Item {
  final String name;
  final String? id;
  final String? parentId;
  final bool isSubLocation;

  Location({
    required this.name,
    required this.id,
    this.parentId,
    this.isSubLocation = false,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final name = json["name"];
    final id = json["id"];
    final parentId = json["parentId"];

    return Location(
      name: name,
      id: id,
      isSubLocation: parentId != null,
      parentId: parentId,
    );
  }
}

