import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/media_provider.dart';
import '../utils/constants.dart';
import '../widgets/tip_icon_widget.dart';

class BottomBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? tapped;

  const BottomBarWidget({super.key, required this.selectedIndex, this.tapped});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomNavigationBar(
          onTap: tapped,
          currentIndex: selectedIndex,
          unselectedItemColor: const Color.fromARGB(255, 107, 122, 108),
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          backgroundColor: Constants.bottomBar,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.folder_rounded,
                  color: Color.fromARGB(255, 107, 122, 108),
                ),
                activeIcon: Icon(
                  Icons.folder_rounded,
                  color: Colors.green,
                ),
                label: 'Local'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.play_circle_filled_rounded,
                  color: Color.fromARGB(255, 107, 122, 108),
                ),
                activeIcon: Icon(
                  Icons.play_circle_filled_rounded,
                  color: Colors.green,
                ),
                label: 'Video'),
          ],
        ),
        Provider.of<MediaProvider>(context).selected.isNotEmpty
            ? Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: Constants.darkPrimary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.check,
                        onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.open_with,
                        onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.content_copy_rounded,
                        onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.playlist_play_rounded,
                        onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.label_outline,
                        onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.edit,
                        onPressed: () {},
                      ),
                    ),
                    InkWell(
                      onLongPress: () {},
                      child: TipIconWidget(
                        icon: Icons.delete,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}
