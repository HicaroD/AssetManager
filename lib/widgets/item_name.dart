import 'package:flutter/material.dart';

import '../tree/items.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';

class ItemName extends StatelessWidget {
  final Item item;

  const ItemName({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        TractianIcons.fromItemType(item.type) ?? Container(),
        const SizedBox(width: 5),
        Text(item.name),
        const SizedBox(width: 5),
        if (item.type == ItemType.component)
          ComponentIcon(component: item as Component)
      ],
    );
  }
}

class ComponentIcon extends StatelessWidget {
  final Component component;

  const ComponentIcon({
    super.key,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (component.sensorType == ComponentSensorType.energy)
          const Icon(
            Icons.bolt,
            color: TractianColors.green,
            size: 17,
          ),
        if (component.status == ComponentStatus.alert)
          const Icon(
            Icons.error,
            color: TractianColors.red,
            size: 17,
          ),
      ],
    );
  }
}
