import 'package:flutter/material.dart';

import '../tree/items.dart';
import '../utils/icons.dart';

class AssetTree extends StatelessWidget {
  final Item item;

  const AssetTree({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: item.children.length,
        itemBuilder: (context, index) {
          final key = item.children.keys.elementAt(index);
          return ItemTile(item: item.children[key]!, paddingLevel: 1);
        },
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final Item item;
  final double paddingLevel;

  const ItemTile({
    super.key,
    required this.item,
    required this.paddingLevel,
  });

  @override
  Widget build(BuildContext context) {
    return item.children.isNotEmpty
        ? ExpansionTile(
            title: Text(item.name),
            leading: TractianIcons.fromItemType(item.type),
            childrenPadding: EdgeInsets.only(left: 5 * paddingLevel),
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: item.children.length,
                itemBuilder: (context, index) {
                  final key = item.children.keys.elementAt(index);
                  return ItemTile(
                    item: item.children[key]!,
                    paddingLevel: paddingLevel + 1,
                  );
                },
              ),
            ],
          )
        : ListTile(
            title: Text(item.name),
            leading: TractianIcons.fromItemType(item.type),
          );
  }
}
