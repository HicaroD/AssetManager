import 'package:flutter/material.dart';

import '../tree/items.dart';
import '../utils/colors.dart';
import '../utils/filters.dart';
import 'item_name.dart';

class AssetTree extends StatefulWidget {
  final Item item;

  const AssetTree({
    super.key,
    required this.item,
  });

  @override
  State<AssetTree> createState() => _AssetTreeState();
}

class _AssetTreeState extends State<AssetTree> {
  Item get item => widget.item;

  final _textInputController = TextEditingController();

  final List<bool> _selectedFilters =
      List.generate(Filter.values.length - 1, (_) => false);
  Filter _selectedFilter = Filter.none;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _textInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Buscar Ativo ou Local",
              ),
              // TODO: analyze performance here
              onChanged: (input) => setState(() {}),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ToggleButtons(
                  selectedColor: TractianColors.darkBlue,
                  isSelected: _selectedFilters,
                  onPressed: (int index) {
                    setState(() {
                      int selectedFilterIndex = -1;

                      for (int buttonIndex = 0;
                          buttonIndex < _selectedFilters.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          _selectedFilters[buttonIndex] =
                              !_selectedFilters[buttonIndex];

                          selectedFilterIndex =
                              _selectedFilters[buttonIndex] ? index : -1;
                        } else {
                          _selectedFilters[buttonIndex] = false;
                        }
                      }
                      _selectedFilter = selectedFilterIndex == -1
                          ? Filter.none
                          : Filter.values.elementAt(selectedFilterIndex);
                    });
                  },
                  children: const <Widget>[
                    Icon(Icons.bolt, color: TractianColors.green),
                    Icon(Icons.error, color: TractianColors.red),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 1,
            width: double.infinity,
            child: Container(
              color: TractianColors.lightGrey,
            ),
          ),
          Children(
            item: item,
            paddingLevel: 1,
            textInputFilter: _textInputController.text,
            selectedFilter: _selectedFilter,
          ),
        ],
      ),
    );
  }
}

class Children extends StatelessWidget {
  final Item item;
  final double paddingLevel;

  final String textInputFilter;
  final Filter selectedFilter;

  const Children({
    super.key,
    required this.item,
    required this.paddingLevel,
    required this.textInputFilter,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: item.children.length,
      itemBuilder: (context, index) {
        final key = item.children.keys.elementAt(index);
        final child = item.children[key]!;
        return ItemTile(
          item: child,
          paddingLevel: paddingLevel + 1,
          textInputFilter: textInputFilter,
          selectedFilter: selectedFilter,
        );
      },
    );
  }

  // bool itemNameContainsInput() {
  //   return item.name.toLowerCase().contains(textInputFilter.toLowerCase());
  // }
  //
  // bool itemTypeIsLocation() {
  //   return item.type == ItemType.location || item.type == ItemType.root;
  // }
}

class ItemTile extends StatelessWidget {
  final Item item;
  final double paddingLevel;

  final String textInputFilter;
  final Filter selectedFilter;

  final bool visible;

  const ItemTile({
    super.key,
    required this.item,
    required this.paddingLevel,
    required this.textInputFilter,
    required this.selectedFilter,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (itemNameDoesNotContainInput() || itemDoesntMatchAnyComponentFilter()) {
      return Container();
    }

    final collapsedIconColor =
        item.children.isEmpty ? Colors.transparent : null;

    return ExpansionTile(
      title: ItemName(item: item),
      shape: const Border(),
      controlAffinity: ListTileControlAffinity.leading,
      // TODO: fix left padding for item that has no children
      childrenPadding: EdgeInsets.only(left: 10 + paddingLevel),
      collapsedIconColor: collapsedIconColor,
      iconColor: collapsedIconColor,
      children: <Widget>[
        Children(
          item: item,
          paddingLevel: paddingLevel,
          textInputFilter: textInputFilter,
          selectedFilter: selectedFilter,
        ),
      ],
    );
  }

  bool itemDoesntMatchAnyComponentFilter() {
    if (item.type != ItemType.component) {
      return false;
    }

    Component component = item as Component;
    if (selectedFilter == Filter.none) {
      return false;
    }

    if ((selectedFilter == Filter.energy &&
            component.sensorType == ComponentSensorType.energy) ||
        (selectedFilter == Filter.alert &&
            component.status == ComponentStatus.alert)) {
      return false;
    }

    return true;
  }

  bool itemNameDoesNotContainInput() {
    if(item.type != ItemType.component && item.children.isNotEmpty) {
      return false;
    }
    return !item.name.toLowerCase().contains(textInputFilter.toLowerCase());
  }
}
