import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/video_provider.dart';
import '../utils/constants.dart';
import 'layout_dialog.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? center;
  final bool showBorder;
  final bool showAcc;
  final SystemUiOverlayStyle? overlayStyle;
  final Color? background;

  const Appbar(
      {super.key,
      required this.title,
      this.actions,
      this.leading,
      this.overlayStyle,
      this.background,
      this.center,
      this.showBorder = false,
      this.showAcc = true});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: center ??
          Text(
            title,
            style: const TextStyle(color: Constants.textColor),
          ),
      leading: leading,
      elevation: 0,
      centerTitle: center != null ? true : false,
      actions: actions ??
          [
            IconButton(
              onPressed: () {
                Provider.of<VideoProvider>(context, listen: false)
                    .initializeVideoDirs();
              },
              icon: const Icon(
                Icons.search_rounded,
                color: Constants.textColor,
              ),
              splashRadius: 20,
              tooltip: 'Search',
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                useSafeArea: false,
                barrierDismissible: false,
                barrierColor: Colors.black45,
                builder: (context) => const LayoutDialog(),
              ),
              icon: const Icon(
                Icons.auto_awesome_mosaic_outlined,
                color: Constants.textColor,
              ),
              splashRadius: 20,
              tooltip: 'View Menu',
            ),
            showAcc
                ? Container(
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
                  )
                : Container(),
          ],
      systemOverlayStyle: overlayStyle,
      flexibleSpace: background != null
          ? Container(
              decoration: BoxDecoration(
                  color: background,
                  border:
                      const Border(bottom: BorderSide(color: Colors.white10))),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Constants.primaryDark, Constants.darkPrimary]),
                  border: Border(
                      bottom: BorderSide(
                          color: showBorder
                              ? Colors.white10
                              : Colors.transparent))),
            ),
    );
  }
}
