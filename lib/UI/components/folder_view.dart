import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/app_provider.dart';
import '../../PROVIDERS/video_provider.dart';
import '../utils/constants.dart';
import '../utils/widget_data.dart';
import '../widgets/route_pill_widget.dart';

class FolderView extends StatelessWidget {
  final ScrollController controller;

  const FolderView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, VideoProvider provider, Widget? child) {
        return provider.status == Status.processing
            ? const Center(child: CircularProgressIndicator())
            : Visibility(
                visible: provider.folderDirs.isNotEmpty,
                replacement: const Center(),
                child: Consumer(
                  builder: (context, AppProvider appProvider, child) =>
                      ListView.builder(
                    controller: controller,
                    itemCount: provider.folderDirs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> e = {};
                      bool selected = false;

                      if (index > 0) {
                        e = provider.folderDirs[index - 1];
                        selected = provider.selected.contains(e['pathName']);
                      }

                      return index == 0
                          ? Container(
                              width: double.maxFinite,
                              height: 62,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        RoutePillWidget(
                                  text: WidgetData.routePills[index][0],
                                  recent: index == 0 ? true : false,
                                  leading: WidgetData.routePills[index][1],
                                ),
                                itemCount: WidgetData.routePills.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  width: 8,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (provider.selected.isNotEmpty) {
                                  if (selected) {
                                    provider.removeSelected(e['pathName']);
                                  } else {
                                    provider.addSelected(e['pathName']);
                                  }
                                } else {
                                  Timer(const Duration(milliseconds: 150), () {
                                    appProvider.changeView('file');
                                    appProvider.changeTitle(e['pathName']);
                                  });
                                }
                              },
                              onLongPress: () {
                                if (selected) {
                                  provider.removeSelected(e['pathName']);
                                } else {
                                  provider.addSelected(e['pathName']);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                color: selected
                                    ? const Color.fromARGB(32, 255, 255, 255)
                                    : Colors.transparent,
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Icon(
                                          Icons.folder_rounded,
                                          color: selected
                                              ? const Color.fromARGB(
                                                  119, 255, 255, 255)
                                              : const Color.fromARGB(
                                                  77, 255, 255, 255),
                                          size: 70,
                                        ),
                                        selected
                                            ? const Icon(
                                                Icons.check_circle_rounded,
                                                color: Colors.white,
                                              )
                                            : Container(),
                                        // Positioned(
                                        //   top: 9,
                                        //   right: -3,
                                        //   child: Container(
                                        //     width: 17,
                                        //     height: 17,
                                        //     decoration: BoxDecoration(
                                        //         color: Colors.red,
                                        //         borderRadius:
                                        //             BorderRadius.circular(17)),
                                        //     child: const Center(
                                        //         child: Text(
                                        //       '4',
                                        //       style: TextStyle(
                                        //           color: Colors.white, fontSize: 11),
                                        //     )),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e['pathName'],
                                          style: const TextStyle(
                                              color: Constants.textColor,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${e['videos'].length} videos',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
              );
      },
    );
  }
}
