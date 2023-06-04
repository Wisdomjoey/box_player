import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CheckboxWidget extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool?) onChanged;

  const CheckboxWidget(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          children: [
            Checkbox(
              onChanged: onChanged,
              value: value,
              overlayColor: MaterialStatePropertyAll(Constants.textColor.withAlpha(40)),
              checkColor: Constants.secondary,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            Text(
              text,
              style: const TextStyle(color: Constants.textColor, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
