import 'package:flutter/material.dart';

import '../tree/items.dart';
import '../utils/icons.dart';

class ItemName extends StatelessWidget {
  final String name;
  final ItemType type;

  const ItemName({
    super.key,
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TractianIcons.fromItemType(type) ?? Container(),
        const SizedBox(width: 5),
        Text(name),
      ],
    );
  }
}
