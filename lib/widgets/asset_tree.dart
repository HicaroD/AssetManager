import 'package:flutter/material.dart';

import '../processor/location.dart';
import '../processor/tree.dart';

class AssetTree extends StatefulWidget {
  final Tree tree;

  const AssetTree({
    super.key,
    required this.tree,
  });

  @override
  State<AssetTree> createState() => _AssetTreeState();
}

class _AssetTreeState extends State<AssetTree> {
  Tree get tree => widget.tree;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: tree.root.length,
        itemBuilder: (context, index) {
          final nodes = tree.root;

          final nodeKey = nodes.keys.elementAt(index);
          final currentNode = nodes[nodeKey]!;

          final nodeChildren = currentNode.children.values;

          return ExpansionTile(
            title: Text(currentNode.item.getName()),
            children: <Widget>[
              for (final nodeChild in nodeChildren)
                ChildrenTree(child: nodeChild),
            ],
          );
        },
      ),
    );
  }
}

class ChildrenTree extends StatefulWidget {
  final Node child;

  const ChildrenTree({
    super.key,
    required this.child,
  });

  @override
  State<ChildrenTree> createState() => _ChildrenTreeState();
}

class _ChildrenTreeState extends State<ChildrenTree> {
  Node get child => widget.child;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: child.children.length,
      itemBuilder: (context, index) {
        final children = child.children;
        final childrenKey = children.keys.elementAt(index);

        final current = children[childrenKey]!;
        final currentItem = current.item;

        return ExpansionTile(
          title: Text(child.item.getName()),
          children: <Widget>[
            if (currentItem is Asset)
              Text("Asset '${currentItem.getName()}'")
            else if (currentItem is Location)
              ChildrenTree(child: current)
          ],
        );
      },
    );
  }
}
