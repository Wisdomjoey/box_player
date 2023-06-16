import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/app_provider.dart';
import '../../PROVIDERS/media_provider.dart';
import '../utils/constants.dart';
import '../utils/widget_data.dart';
import '../widgets/route_pill_widget.dart';

class FolderView extends StatefulWidget {
  const FolderView({super.key});

  @override
  State<FolderView> createState() => _FolderViewState();
}

class _FolderViewState extends State<FolderView> {
  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).initializeSelects(10);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<MediaProvider>(context, listen: false).fetchMediaWithIsolate();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, MediaProvider provider, Widget? child) {
        return provider.status == Status.processing
            ? const Center(child: CircularProgressIndicator())
            : Visibility(
                visible: provider.videoDirs.isNotEmpty,
                replacement: const Center(),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 62,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (BuildContext context, int index) =>
                            RoutePillWidget(
                          text: WidgetData.routePills[index][0],
                          recent: index == 0 ? true : false,
                          leading: WidgetData.routePills[index][1],
                        ),
                        itemCount: WidgetData.routePills.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 8,
                        ),
                      ),
                    ),
                    Column(
                        children: WidgetData.folders.map((e) {
                      int index = WidgetData.folders.indexOf(e);
                      int selected = Provider.of<AppProvider>(context).selected;
                      List<bool> selects =
                          Provider.of<AppProvider>(context).selects;

                      return InkWell(
                        onTap: () {
                          if (selected > 0) {
                            if (selects[index]) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .decreaseSelected();
                              Provider.of<AppProvider>(context, listen: false)
                                  .updateSelects(false, index);
                            } else {
                              Provider.of<AppProvider>(context, listen: false)
                                  .increaseSelected();
                              Provider.of<AppProvider>(context, listen: false)
                                  .updateSelects(true, index);
                            }
                          } else {
                            Timer(
                                const Duration(milliseconds: 150),
                                () => Provider.of<AppProvider>(context,
                                        listen: false)
                                    .changeView('file'));
                          }
                        },
                        onLongPress: () {
                          if (selects[index]) {
                            Provider.of<AppProvider>(context, listen: false)
                                .decreaseSelected();
                            Provider.of<AppProvider>(context, listen: false)
                                .updateSelects(false, index);
                          } else {
                            Provider.of<AppProvider>(context, listen: false)
                                .increaseSelected();
                            Provider.of<AppProvider>(context, listen: false)
                                .updateSelects(true, index);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          color: selects[index]
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
                                    color: selects[index]
                                        ? const Color.fromARGB(
                                            119, 255, 255, 255)
                                        : const Color.fromARGB(
                                            77, 255, 255, 255),
                                    size: 70,
                                  ),
                                  selects[index]
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e['name'],
                                    style: const TextStyle(
                                        color: Constants.textColor,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${e['videos']} videos',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()),
                  ],
                ),
              );
      },
    );
  }
}
