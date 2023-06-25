import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../../PROVIDERS/app_provider.dart';
import '../../PROVIDERS/media_provider.dart';
import '../utils/constants.dart';

class FileView extends StatelessWidget {
  final List videos;

  const FileView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<AppProvider>(context, listen: false).changeView('folder');

        return Future.delayed(Duration.zero, () => false);
      },
      child: Consumer(
        builder: (context, MediaProvider provider, child) {
          return Column(
            children: videos.map((e) {
              bool selected = provider.selected.contains(e);

              return InkWell(
                onTap: () {
                  if (provider.selected.isNotEmpty) {
                    if (selected) {
                      provider.removeSelected(e);
                    } else {
                      provider.addSelected(e);
                    }
                  } else {}
                },
                onLongPress: () {
                  if (selected) {
                    provider.removeSelected(e);
                  } else {
                    provider.addSelected(e);
                  }
                },
                child: Ink(
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  color: selected
                      ? const Color.fromARGB(50, 255, 255, 255)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 95,
                        child: Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('assets/images/b3.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Container(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: selected
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withAlpha(90)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(top: 5, left: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(2)),
                                child: const Text(
                                  'NEW',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 5, right: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(202, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(2)),
                                child: const Text(
                                  '17:05',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            selected
                                ? const Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 3, right: 3),
                                      child: Icon(
                                        Icons.check_circle,
                                        color:
                                            Color.fromARGB(223, 255, 255, 255),
                                        size: 22,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              path.basenameWithoutExtension(e),
                              style: const TextStyle(
                                color: Constants.textColor,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (context) => _videoMenu(context)),
                            child: Ink(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.more_vert,
                                color: Constants.textColor,
                                size: 20,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _videoMenu(BuildContext context) {
    return Container(
      height: 400,
      color: Constants.secondary,
      child: Scrollbar(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'chjhgwd wjchbhwb jwhygcywh wgywg dcgywiw gwigw hw wg wiiwg',
                style: TextStyle(
                    color: Constants.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.offline_share,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'BOX Share',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          color: Constants.textColor,
                        ),
                        Icon(
                          Icons.lock_rounded,
                          size: 8,
                          color: Constants.textColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Lock in Private Folder',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.headphones_outlined,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Convert to MP3',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.share_outlined,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Rename',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.crop_rounded,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Cut',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.subtitles_outlined,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Search Subtitle',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Properties',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.playlist_add_rounded,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Add To Playlist',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: Constants.textColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
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
