import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LayoutBtn extends StatelessWidget {
  final bool active;
  final String text;
  final IconData icon;
  final Function()? onTap;

  const LayoutBtn(
      {super.key,
      required this.active,
      required this.text,
      required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        child: Ink(
          width: 55,
          height: 55,
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: active
                    ? Theme.of(context).primaryColor
                    : Constants.textColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    color: active
                        ? Theme.of(context).primaryColor
                        : Constants.textColor,
                    fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
