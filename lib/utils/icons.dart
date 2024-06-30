import 'package:flutter/material.dart';

import '../tree/items.dart';

class TractianIcons {
  static final location = Image.asset("assets/icons/location.png");
  static final asset = Image.asset("assets/icons/asset.png");
  static final component = Image.asset("assets/icons/component.png");

  static Image? fromItemType(ItemType type) {
    switch (type) {
      case ItemType.root:
        return null;
      case ItemType.location:
        return location;
      case ItemType.asset:
        return asset;
      case ItemType.component:
        return component;
    }
  }
}
