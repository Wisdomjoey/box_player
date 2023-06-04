import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/widget_data.dart';
import '../widgets/checkbox_widget.dart';
import '../widgets/layout_button.dart';
import '../widgets/switch_tile_widget.dart';

class LayoutDialog extends StatelessWidget {
  const LayoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> activeTile = ['All folders'];

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Constants.secondary),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white24))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'View Mode',
                                  style: TextStyle(
                                      color: Constants.textColor, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white24))),
                                    child: Wrap(
                                      children: WidgetData.view
                                          .map((e) => LayoutBtn(
                                                onTap: () {},
                                                text: e['text'],
                                                icon: e['icon'],
                                                active: activeTile
                                                    .contains(e['text']),
                                              ))
                                          .toList(),
                                    ))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Layout',
                                  style: TextStyle(
                                      color: Constants.textColor, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  children: WidgetData.layout
                                      .map((e) => LayoutBtn(
                                            onTap: () {},
                                            text: e['text'],
                                            icon: e['icon'],
                                            active:
                                                activeTile.contains(e['text']),
                                          ))
                                      .toList(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white24))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sort',
                              style: TextStyle(
                                  color: Constants.textColor, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              children: WidgetData.sort
                                  .map((e) => LayoutBtn(
                                        onTap: () {},
                                        text: e['text'],
                                        icon: e['icon'],
                                        active: activeTile.contains(e['text']),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: 30,
                                    child: TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5)))),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Theme.of(context)
                                                        .primaryColor
                                                        .withAlpha(30))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_upward_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 12,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'A to Z',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 10),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: 30,
                                    child: TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Constants
                                                            .textColor
                                                            .withAlpha(40)),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5)))),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.transparent)),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_downward_rounded,
                                              color: Constants.textColor,
                                              size: 12,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Z to A',
                                              style: TextStyle(
                                                  color: Constants.textColor,
                                                  fontSize: 10),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ExpansionTile(
                          title: const Text(
                            'Fields',
                            style: TextStyle(
                                color: Constants.textColor, fontSize: 14),
                          ),
                          childrenPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          iconColor: Constants.textColor,
                          collapsedIconColor: Constants.textColor,
                          children: [
                            Row(
                              children:
                                  ['Thumbnail', 'Length', 'File extension']
                                      .map((e) => CheckboxWidget(
                                            onChanged: (bool? value) {},
                                            text: e,
                                            value: true,
                                          ))
                                      .toList(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children:
                                  ['Played time', 'Resolution', 'Frame rate']
                                      .map((e) => CheckboxWidget(
                                            onChanged: (bool? value) {},
                                            text: e,
                                            value: false,
                                          ))
                                      .toList(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: ['Path', 'Size', 'Date']
                                  .map((e) => CheckboxWidget(
                                        onChanged: (bool? value) {},
                                        text: e,
                                        value: false,
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border:
                                Border(top: BorderSide(color: Colors.white24))),
                        child: Column(
                          children: [
                            'Display length over thumbnail',
                            'Show hidden files and folders',
                            'Recognize .nomedia'
                          ]
                              .map((e) => SwitchTileWidget(
                                    onChanged: (bool value) {},
                                    value: true,
                                    text: e,
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white24))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 15)),
                              splashFactory: InkSplash.splashFactory),
                          child: const Text('CANCEL')),
                      TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 15)),
                              splashFactory: InkSplash.splashFactory),
                          child: const Text('DONE')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
