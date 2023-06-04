import 'package:flutter/material.dart';

import '../utils/constants.dart';

class TipIconWidget extends StatelessWidget {
  final String? tooltip;
  final IconData icon;
  final Function()? onPressed;

  const TipIconWidget(
      {super.key, this.tooltip, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Constants.textColor,
      ),
      splashRadius: 20,
      tooltip: tooltip,
    );
  }
}
