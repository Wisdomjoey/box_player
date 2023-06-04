import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/widget_data.dart';

class VideoAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;

  const VideoAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 34);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Constants.primaryDark, Constants.darkPrimary])),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(34),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(3),
                borderSide:
                    const BorderSide(width: 2.5, color: Constants.textColor),),
            indicatorColor: Constants.textColor,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            labelStyle: const TextStyle(
                color: Constants.textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600),
            labelPadding: const EdgeInsets.symmetric(horizontal: 11),
            unselectedLabelStyle:
                const TextStyle(color: Constants.textColor, fontSize: 11),
            tabs: WidgetData.videoTabs,
          ),
        ),
      ),
    );
  }
}
