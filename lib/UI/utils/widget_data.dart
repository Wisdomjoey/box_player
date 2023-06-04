import 'package:flutter/material.dart';

import 'constants.dart';

class WidgetData {
  static const videoTabPages = <Widget>[
    Text('home'),
    Text('2'),
    Text('3'),
    Text('4'),
    Text('5'),
  ];

  static final videoTabs = <Widget>[
    const SizedBox(
      height: 34,
      child: Tab(
        icon: Icon(Icons.home_rounded),
      ),
    ),
    const SizedBox(
        height: 34,
        child: Tab(
          text: 'BOX ONE 🔥',
        )),
    const SizedBox(
        height: 34,
        child: Tab(
          text: 'MOVIES',
        )),
    const SizedBox(
        height: 34,
        child: Tab(
          text: 'SHOWS',
        )),
    const SizedBox(
        height: 34,
        child: Tab(
          text: 'PODCAST 🎙️',
        )),
  ];

  static const folders = <Map<String, dynamic>>[
    {'name': 'Camera', 'videos': 15, 'selected': false},
    {'name': 'Download', 'videos': 243, 'selected': false},
    {'name': 'Document', 'videos': 23, 'selected': false},
    {'name': 'Internal Memory', 'videos': 18, 'selected': false},
    {'name': 'Movies', 'videos': 101, 'selected': false},
    {'name': 'Camera1', 'videos': 15, 'selected': false},
    {'name': 'Download1', 'videos': 243, 'selected': false},
    {'name': 'Document1', 'videos': 23, 'selected': false},
    {'name': 'Internal Memory1', 'videos': 18, 'selected': false},
    {'name': 'Movies1', 'videos': 101, 'selected': false},
  ];

  static const routePills = <List>[
    [
      'Music',
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Icon(
            Icons.folder_rounded,
            size: 16,
            color: Constants.textColor,
          ),
          Icon(
            Icons.music_note_rounded,
            size: 7,
            color: Constants.darkPrimary,
          ),
        ],
      )
    ],
    [
      'Share',
      Icon(
        Icons.mobile_screen_share_rounded,
        size: 15,
        color: Constants.textColor,
      )
    ],
    [
      'Downloader',
      Icon(
        Icons.smart_display_rounded,
        size: 16,
        color: Constants.textColor,
      )
    ],
    [
      'Privacy',
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Icon(
            Icons.folder_rounded,
            size: 16,
            color: Constants.textColor,
          ),
          Icon(
            Icons.lock_rounded,
            size: 7,
            color: Constants.darkPrimary,
          ),
        ],
      )
    ],
    [
      'Video Playlist',
      Icon(
        Icons.playlist_add_rounded,
        size: 18,
        color: Constants.textColor,
      )
    ]
  ];

  static const view = <Map<String, dynamic>>[
    {
      'icon': Icons.folder_copy_rounded,
      'text': 'All folders',
    },
    {
      'icon': Icons.folder_rounded,
      'text': 'Folders',
    },
    {
      'icon': Icons.file_copy_rounded,
      'text': 'Files',
    },
  ];

  static const layout = <Map<String, dynamic>>[
    {
      'icon': Icons.view_day_rounded,
      'text': 'List',
    },
    {
      'icon': Icons.view_module_rounded,
      'text': 'Grid',
    },
  ];

  static const sort = <Map<String, dynamic>>[
    {
      'icon': Icons.title_rounded,
      'text': 'Title',
    },
    {
      'icon': Icons.calendar_month_rounded,
      'text': 'Date',
    },
    {
      'icon': Icons.access_time_filled_rounded,
      'text': 'Played time',
    },
    {
      'icon': Icons.slow_motion_video_rounded,
      'text': 'Status',
    },
    {
      'icon': Icons.straighten_rounded,
      'text': 'Length',
    },
    {
      'icon': Icons.height_rounded,
      'text': 'Size',
    },
    {
      'icon': Icons.hd_rounded,
      'text': 'Resolution',
    },
    {
      'icon': Icons.room,
      'text': 'Path',
    },
    {
      'icon': Icons.sixty_fps_rounded,
      'text': 'Frame rate',
    },
    {
      'icon': Icons.audio_file_rounded,
      'text': 'Type',
    },
  ];
}
