import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/app_provider.dart';
import '../../PROVIDERS/video_provider.dart';
import '../components/appbar.dart';
import '../components/bottom_bar.dart';
import '../components/file_view.dart';
import '../components/folder_view.dart';
import '../components/video_appbar.dart';
import '../utils/constants.dart';
import '../utils/widget_data.dart';
import '../widgets/tip_icon_widget.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  int index = 0;
  bool showFloat = true;
  bool showBar = false;
  bool showBorder = false;
  final _controller = ScrollController();

  checkScrollPosition() {
    if (_controller.position.atEdge) {
      if (_controller.position.pixels == 0) {
        setState(() => showBorder = false);
      }
    } else {
      setState(() => showBorder = true);
    }
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      AsyncMemoizer().runOnce(() =>
          Provider.of<VideoProvider>(context, listen: false).fetchMedia());
    });

    _controller.addListener(() => checkScrollPosition());
  }

  @override
  void dispose() {
    _controller.removeListener(() => checkScrollPosition());
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    permission() async {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }

    permission();

    return Consumer(
      builder: (context, VideoProvider provider, child) {
        return DefaultTabController(
            length: WidgetData.videoTabs.length,
            child: Scaffold(
              appBar: index == 1
                  ? VideoAppbar(
                      title: const Text('BOXPLAYER'),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search_rounded,
                            color: Constants.textColor,
                          ),
                          splashRadius: 20,
                          tooltip: 'Search',
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Constants.textColor,
                          ),
                          splashRadius: 20,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.download_outlined,
                            color: Constants.textColor,
                          ),
                          splashRadius: 20,
                          tooltip: 'View Menu',
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 14, top: 14, bottom: 14, left: 10),
                          width: 27,
                          // height: 24,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 193, 255, 197),
                              borderRadius: BorderRadius.circular(24)),
                          child: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 197, 197, 197),
                          ),
                        ),
                      ],
                    )
                  : (provider.selected.isNotEmpty
                      ? Appbar(
                          title:
                              '${provider.selected} / ${provider.selected.length} Selected',
                          background: Constants.darkPrimary,
                          overlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: Colors.black),
                          leading: TipIconWidget(
                            icon: Icons.close,
                            tooltip: 'Close',
                            onPressed: () {
                              provider.clearSelected();
                            },
                          ),
                          actions: [
                            TipIconWidget(
                              icon: Icons.play_arrow,
                              tooltip: 'Play selected items',
                              onPressed: () {},
                            ),
                            TipIconWidget(
                              icon: Icons.info_outline_rounded,
                              tooltip: 'Properties',
                              onPressed: () {},
                            ),
                            TipIconWidget(
                              icon: Icons.more_vert,
                              tooltip: 'More options',
                              onPressed: () {},
                            ),
                          ],
                        )
                      : Appbar(
                          title: Provider.of<AppProvider>(context).appbarTitle,
                          showBorder: showBorder,
                          leading:
                              Provider.of<AppProvider>(context).view == 'file'
                                  ? TipIconWidget(
                                      icon: Icons.arrow_back,
                                      onPressed: () => Provider.of<AppProvider>(
                                              context,
                                              listen: false)
                                          .changeView('folder'),
                                    )
                                  : null,
                          showAcc:
                              Provider.of<AppProvider>(context).view == 'folder'
                                  ? true
                                  : false,
                          overlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: Colors.transparent),
                        )) as PreferredSizeWidget,
              body: index == 1
                  ? const TabBarView(children: WidgetData.videoTabPages)
                  : NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.reverse) {
                          setState(() {
                            showFloat = false;
                            showBar = true;
                          });
                        } else if (notification.direction ==
                            ScrollDirection.forward) {
                          setState(() {
                            showFloat = true;
                            showBar = true;
                          });
                        } else if (notification.direction ==
                            ScrollDirection.idle) {
                          Timer(const Duration(seconds: 2),
                              () => setState(() => showBar = false));
                        }

                        return true;
                      },
                      child: Scrollbar(
                        controller: _controller,
                        interactive: true,
                        trackVisibility: showBar,
                        thumbVisibility: showBar,
                        thickness: 7,
                        radius: const Radius.circular(7),
                        child:
                            Provider.of<AppProvider>(context).view == 'folder'
                                ? FolderView(
                                    controller: _controller,
                                  )
                                : FileView(
                                    directory: Provider.of<AppProvider>(context,
                                            listen: false)
                                        .appbarTitle,
                                    controller: _controller,
                                  ),
                      ),
                    ),
              floatingActionButton: AnimatedScale(
                scale: showFloat ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomBarWidget(
                selectedIndex: index,
                tapped: (p0) => setState(() => index = p0),
              ),
            ));
      },
    );
  }
}
