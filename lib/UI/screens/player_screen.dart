import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import '../../UTILS/system_utils.dart';
import '../utils/constants.dart';

class PlayerScreen extends StatefulWidget {
  final String videoPath;

  const PlayerScreen({super.key, required this.videoPath});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController _controller;
  final _scrollController = ScrollController();
  bool isInitialized = false;
  bool show = false;
  bool scrolling = false;
  double containerWidth = double.maxFinite;
  double containerHeight = double.maxFinite;
  double maxWidth = double.maxFinite;
  double maxHeight = double.maxFinite;
  double videoWidth = 0;
  double videoHeight = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  double aspectRatio = 1;
  String initialAspect = '';
  String orientation = 'portrait';
  List<Map<String, dynamic>> shortcuts = [
    {'icon': ''},
    {'icon': Icons.keyboard_arrow_right_rounded},
    {'icon': Icons.screen_rotation_rounded, 'text': 'Screen Rotation'},
    {'icon': Icons.headset_rounded, 'text': 'Background play'},
    {'icon': Icons.edit_outlined, 'text': 'Customize Items'},
    {'icon': Icons.one_x_mobiledata_rounded, 'text': 'Speed'},
    {'icon': Icons.tune_rounded, 'text': 'Equaliser'},
    {'icon': Icons.multiple_stop_rounded, 'text': 'A - B repeat'},
    {'icon': Icons.timer_outlined, 'text': 'Sleep Timer'},
    {'icon': Icons.volume_off_rounded, 'text': 'Mute'},
    {'icon': Icons.repeat_rounded, 'text': 'Loop'},
    {'icon': Icons.shuffle_rounded, 'text': 'Shuffle'},
    {'icon': Icons.nights_stay_rounded, 'text': 'Night mode'},
  ];

  changeVideoAspect(String aspect) {
    if (aspect == initialAspect) return;

    switch (aspect) {
      case 'fit':
        fitAspect();
        setState(() {
          initialAspect = aspect;
        });
        break;
      case 'stretch':
        stretchAspect();
        setState(() {
          initialAspect = aspect;
        });
        break;
      case '100%':
        fullAspect();
        setState(() {
          initialAspect = aspect;
        });
        break;
      case 'crop':
        cropAspect();
        setState(() {
          initialAspect = aspect;
        });
        break;
      default:
    }
  }

  fitAspect() {
    double widthDiff = screenWidth - (videoWidth / 100);
    double heightDiff = screenHeight - (videoHeight / 100);

    setState(() {
      if (orientation == 'portrait') {
        if (widthDiff < heightDiff) {
          containerWidth = screenWidth;
          containerHeight = screenWidth / aspectRatio;
        } else {
          containerHeight = screenHeight;
          containerWidth = screenHeight * aspectRatio;
        }
      } else {
        if (heightDiff < widthDiff) {
          containerHeight = screenHeight;
          containerWidth = screenHeight * aspectRatio;
        } else {
          containerWidth = screenWidth;
          containerHeight = screenWidth / aspectRatio;
        }
      }

      maxWidth = screenWidth;
      maxHeight = screenHeight;
    });
  }

  cropAspect() {
    double widthDiff = screenWidth - (videoWidth / 100);
    double heightDiff = screenHeight - (videoHeight / 100);

    setState(() {
      if (orientation == 'portrait') {
        if (heightDiff > widthDiff) {
          containerHeight = screenHeight;
          containerWidth = screenHeight * aspectRatio;
          maxHeight = screenHeight;
          maxWidth = screenHeight * aspectRatio;
        } else {
          containerWidth = screenWidth;
          containerHeight = screenWidth / aspectRatio;
          maxWidth = screenWidth;
          maxHeight = screenWidth / aspectRatio;
        }
      } else {
        if (widthDiff > heightDiff) {
          containerWidth = screenWidth;
          containerHeight = screenWidth / aspectRatio;
          maxWidth = screenWidth;
          maxHeight = screenWidth / aspectRatio;
        } else {
          containerHeight = screenHeight;
          containerWidth = screenHeight * aspectRatio;
          maxHeight = screenHeight;
          maxWidth = screenHeight * aspectRatio;
        }
      }
    });
  }

  stretchAspect() {
    setState(() {
      containerWidth = screenWidth;
      containerHeight = screenHeight;
      maxWidth = screenWidth;
      maxHeight = screenHeight;
    });
  }

  fullAspect() {
    double vWidth = videoWidth / 2;
    double vHeight = videoHeight / 2;

    if (vWidth > screenWidth || vHeight > screenHeight) {
      fitAspect();
    } else {
      setState(() {
        containerWidth = vWidth;
        containerHeight = vHeight;
        maxWidth = screenWidth;
        maxHeight = screenHeight;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((value) async {
        screenWidth = MediaQuery.sizeOf(context).width;
        screenHeight = MediaQuery.sizeOf(context).height;

        if (_controller.value.aspectRatio > 1.0) {
          if (MediaQuery.orientationOf(context) != Orientation.landscape) {
            screenWidth = MediaQuery.sizeOf(context).height;
            screenHeight = MediaQuery.sizeOf(context).width;
            orientation = 'landscape';
            await SystemUtils.setLandscapeOrientation();
          }
        } else {
          if (MediaQuery.orientationOf(context) != Orientation.portrait) {
            screenWidth = MediaQuery.sizeOf(context).height;
            screenHeight = MediaQuery.sizeOf(context).width;
            orientation = 'portrait';
            await SystemUtils.setPortraitOrientation();
          }
        }

        await SystemUtils.setFullScreen();

        setState(() {
          aspectRatio = _controller.value.aspectRatio;
          videoWidth = _controller.value.size.width;
          videoHeight = _controller.value.size.height;
          isInitialized = true;
        });

        _controller.play();
        changeVideoAspect('fit');
      });
  }

  @override
  void dispose() {
    SystemUtils.resetSystemUIMode();

    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemUtils.resetOrientation();

        return Future(() => true);
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            systemNavigationBarColor: Colors.black),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Visibility(
            visible: isInitialized,
            child: GestureDetector(
              onTap: () {
                show
                    ? SystemUtils.setFullScreen()
                    : SystemUtils.resetSystemUIMode();

                setState(() {
                  show = !show;

                  if (show) {
                    Timer(const Duration(seconds: 2), () {
                      SystemUtils.setFullScreen();
                      show = false;
                    });
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  OverflowBox(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    child: SizedBox(
                      width: containerWidth,
                      height: containerHeight,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Constants.textColor,
                                      ),
                                      tooltip: 'Navigate up',
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'video name.mp4',
                                      style: TextStyle(
                                          color: Constants.textColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Text(
                                          'HW',
                                          style: TextStyle(
                                              color: Constants.textColor),
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.more_vert)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: 70,
                              child: NotificationListener(
                                onNotification: (notification) {
                                  setState(() {
                                    if (_scrollController.position.pixels > 0) {
                                      scrolling = true;
                                    } else {
                                      scrolling = false;
                                    }
                                  });

                                  return true;
                                },
                                child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  itemCount: shortcuts.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width -
                                                310,
                                      );
                                    }

                                    if (index == 1) {
                                      return scrolling
                                          ? const SizedBox(
                                              width: 35,
                                            )
                                          : SizedBox(
                                              width: 35,
                                              height: 70,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 40,
                                                  child: Center(
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(
                                                              136, 0, 0, 0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                        child: Icon(
                                                          shortcuts[index]
                                                              ['icon'],
                                                          color: Constants
                                                              .textColor,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                    }

                                    return SizedBox(
                                      width: 55,
                                      height: 70,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    136, 0, 0, 0),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Center(
                                              child: Icon(
                                                shortcuts[index]['icon'],
                                                color: Constants.textColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            shortcuts[index]['text'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Constants.textColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'video name.mp4',
                                  style: TextStyle(
                                      color: Constants.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Slider(value: 0, onChanged: (val) {}),
                                const Text(
                                  'video name.mp4',
                                  style: TextStyle(
                                      color: Constants.textColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
