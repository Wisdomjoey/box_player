import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RoutePillWidget extends StatelessWidget {
  final String text;
  final bool recent;
  final Widget leading;
  final Function()? tapped;

  const RoutePillWidget(
      {super.key,
      required this.text,
      required this.recent,
      required this.leading,
      this.tapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
        child: Row(
          children: [
            recent
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(50),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            bottomLeft: Radius.circular(32))),
                    child: Center(
                      child: Icon(
                        Icons.access_time_filled_rounded,
                        size: 17,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Container(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: recent
                      ? const BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32))
                      : BorderRadius.circular(32)),
              child: Center(
                child: Row(
                  children: [
                    leading,
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                          color: Constants.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
