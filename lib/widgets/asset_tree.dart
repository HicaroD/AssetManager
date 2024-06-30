import 'package:flutter/material.dart';

import '../tree/items.dart';

class AssetTree extends StatelessWidget {
  final Item item;

  const AssetTree({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return item.name == "root"
        ? Children(children: item.children)
        : ExpansionTile(
            title: Text(item.name),
            children: <Widget>[
              Children(children: item.children),
            ],
          );
  }
}

class Children extends StatelessWidget {
  final Map<String, Item> children;

  const Children({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: children.length,
        itemBuilder: (context, index) {
          final key = children.keys.elementAt(index);
          return AssetTree(item: children[key]!);
        },
      ),
    );
  }
}
