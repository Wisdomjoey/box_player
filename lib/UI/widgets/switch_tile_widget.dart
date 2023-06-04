import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SwitchTileWidget extends StatelessWidget {
  final bool value;
  final String text;
  final Function(bool) onChanged;

  const SwitchTileWidget(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SwitchListTile(
        onChanged: onChanged,
        value: value,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        visualDensity: const VisualDensity(vertical: -2),
        title: Text(
          text,
          style: const TextStyle(color: Constants.textColor, fontSize: 14),
        ),
      ),
    );
  }
}
