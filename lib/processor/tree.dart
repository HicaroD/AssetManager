import 'assets.dart';
import 'location.dart';
import 'processor.dart';

class Node {
  final Item item;
  final Map<String, Node> children = {};

  Node(this.item);
}

class Tree {
  final Map<String, Node> root = {};

  void generateTree(
    Map<String, Location> locations,
    Map<String, Assets> assets,
  ) {
    Tree assetsTree = _buildAssetsTree(assets);

    for (final assetEntry in assets.entries) {
      final assetKey = assetEntry.key;
      final asset = assetEntry.value;
      if (asset.parentType == ParentType.root) {
        _addNodeToRoot(assetKey, Node(asset));
      } else if (asset.parentType == ParentType.location) {
        Location currentLocation = locations[asset.locationId!]!;
        final currentAssetNode = assetsTree.root[assetKey]!;

        if (currentLocation.isSubLocation) {
          final parentLocation = locations[currentLocation.parentId]!;
          _addNewLocation(parentLocation);
          _addNewSublocation(parentLocation, currentLocation);
          _addNodeToSublocation(
            parentLocation,
            currentLocation,
            assetKey,
            currentAssetNode,
          );
        } else {
          _addNewLocation(currentLocation);
          _addAssetToLocation(currentLocation, assetKey, currentAssetNode);
        }
      }
    }
  }

  void _addNodeToRoot(String assetKey, Node node) {
    root.putIfAbsent(assetKey, () => node);
  }

  void _addNewLocation(Location location) {
    root.putIfAbsent(location.id!, () => Node(location));
  }

  void _addNewSublocation(Location parentLocation, Location sublocation) {
    // root.putIfAbsent(parentLocation.id!, () => Node(parentLocation));
    root[parentLocation.id]!
        .children
        .putIfAbsent(sublocation.id!, () => Node(sublocation));
  }

  void _addAssetToLocation(Location location, String nodeKey, Node node) {
    root[location.id!]!.children.putIfAbsent(nodeKey, () => node);
  }

  void _addNodeToSublocation(
    Location parentLocation,
    Location subLocation,
    String nodeKey,
    Node node,
  ) {
    root[parentLocation.id]!
        .children[subLocation.id]!
        .children
        .putIfAbsent(nodeKey, () => node);
  }

  Tree _buildAssetsTree(Map<String, Assets> assets) {
    final assetsTree = Tree();

    assets.forEach((id, asset) {
      if (asset.parentType == ParentType.asset) {
        final parentId = asset.parentId!;
        final parentAsset = assets[parentId]!;
        assetsTree.root.putIfAbsent(parentId, () => Node(parentAsset));
        assetsTree.root[parentId]!.children.putIfAbsent(id, () => Node(asset));
      } else if (asset.parentType == ParentType.location) {
        assetsTree.root.putIfAbsent(id, () => Node(asset));
      }
    });

    return assetsTree;
  }
}

class Asset {}
