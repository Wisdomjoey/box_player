import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:path/path.dart' as path;

import '../UI/utils/constants.dart';
import '../UI/utils/helpers.dart';

class FileUtils {
  static handleFiles(Map<String, dynamic> context) {
    try {
      HandledIsolateMessenger messenger = HandledIsolate.initialize(context);

      messenger.listen((msg) async {
        Map<String, Map<String, Map<String, dynamic>>> infos = {};

        for (var i = 0; i < msg['filePaths'].length; i++) {
          final result =
              await sortVideoInfo(msg['mediaProps'][i], msg['filePaths'][i]);

          infos.addAll({
            msg['filePaths'][i]: result,
          });
        }

        final send = IsolateNameServer.lookupPortByName('handleFiles_1');

        if (send != null) {
          send.send(infos);
        }

        messenger.send({'msg': 'done'});
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<List<Map<String, dynamic>>> sortVideoPaths(
      List<String> paths) async {
    List<Map<String, dynamic>> dirs = [];

    for (var vPath in paths) {
      final hPath = path.dirname(vPath);
      final dir = await Directory(hPath).stat();
      final size = (await File(vPath).stat()).size;
      final date = dir.modified;
      final match = dirs.where((ele) => ele['location'] == hPath).toList();

      if (match.isNotEmpty) {
        dirs[dirs.indexOf(match[0])] = {
          ...match[0],
          'size': match[0]['size'] + size,
          'videos': [...match[0]['videos'], vPath]
        };
      } else {
        dirs.add({
          'location': '${hPath[0].toUpperCase()}${hPath.substring(1)}',
          'date':
              '${Helpers.getMonth(date.month, 'M')} ${date.day}, ${date.year}, ${date.hour}:${date.minute}',
          'size': size,
          'pathName': hPath == '/storage/emulated/0'
              ? 'Internal Memory'
              : path.basename(hPath),
          'videos': [vPath]
        });
      }
    }

    return dirs;
  }

  static String getSize(int size) {
    String temp = '';
    dynamic t = 0;

    if (size < 1000) {
      temp = '$size B ($size bytes)';
    } else if (size < 1000000) {
      t = size / 1000;

      temp =
          '${t is int || t > 10 ? t.round() : t.toStringAsPrecision(2)} KB ($size bytes)';
    } else if (size < 1000000000) {
      t = size / 1000000;

      temp =
          '${t is int || t > 10 ? t.round() : t.toStringAsPrecision(2)} MB ($size bytes)';
    } else {
      t = size / 1000000000;

      temp =
          '${t is int || t > 10 ? t.round() : t.toStringAsPrecision(2)} GB ($size bytes)';
    }

    return temp;
  }

  static Future<Map<String, Map<String, dynamic>>> sortVideoInfo(
      Map<dynamic, dynamic>? props, String videoPath) async {
    Map<String, Map<String, dynamic>> temp = {};
    final file = await File(videoPath).stat();
    final date = file.modified;

    temp.addAll({
      'File': {
        'File': path.basename(videoPath),
        'Location': path.dirname(videoPath),
        'Size': getSize(file.size),
        'Date':
            '${Helpers.getMonth(date.month, 'M')} ${date.day}, ${date.year}, ${date.hour}:${date.minute}',
      },
    });

    if (props != null) {
      Map<String, dynamic> format = {...props['format']};
      final streams = props['streams'] as List;
      var formatTags = format['tags'];
      Map<String, dynamic> videoProps = {
        ...(streams.firstWhere(
          (element) => element['codec_type'] == 'video',
          orElse: () => {},
        ))
      };
      Map<String, dynamic> audioProps = {
        ...(streams.firstWhere(
          (element) => element['codec_type'] == 'audio',
          orElse: () => {},
        ))
      };
      String duration = '';
      int h = 0;
      int m = 0;
      int s = 0;

      if (format['duration'] != null) {
        double hours = double.parse(format['duration']) / 3600;
        h = hours.truncate();
        double mins = (hours - h) * 60;
        m = mins.truncate();
        s = ((mins - m) * 60).truncate();
      } else {
        List<String> temp =
            (videoProps['tags']['duration'] ?? videoProps['tags']['DURATION'])
                .split(':');
        h = double.parse(temp[0]).truncate();
        m = double.parse(temp[1]).truncate();
        s = double.parse(temp[2]).truncate();
      }

      duration =
          '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

      temp.addAll({
        'Media': {
          'Title': formatTags != null
              ? formatTags['title'] ?? formatTags['TITLE']
              : null,
          'Description': formatTags != null
              ? formatTags['comment'] ?? formatTags['COMMENT']
              : null,
          'Format': Constants.formatNames[path.extension(format['filename'])],
          'Resolution': '${videoProps['width']} x ${videoProps['height']}',
          'Length': duration,
          'Genre': formatTags != null
              ? formatTags['genre'] ?? formatTags['GENRE']
              : null,
          'Year': formatTags != null
              ? formatTags['date'] ?? formatTags['DATE']
              : null,
          'Album': formatTags != null
              ? formatTags['album'] ?? formatTags['ALBUM']
              : null,
          'Artist': formatTags != null
              ? formatTags['artist'] ?? formatTags['ARTIST']
              : null,
          'Album artist': formatTags != null
              ? formatTags['album_artist'] ?? formatTags['ALBUM_ARTIST']
              : null,
          'Encoding SW': formatTags != null
              ? formatTags['encoder'] ?? formatTags['ENCODER']
              : null,
        },
        'Playback history': {
          'Finished': '',
          'Last playback time': '',
          'Last position': '',
        },
        'Stream #1': videoProps.isNotEmpty
            ? {
                'Type': 'Video',
                'Codec': videoProps['codec_name'] != null
                    ? '${videoProps['codec_name'].toUpperCase()}'
                    : null,
                'Profile': videoProps['profile'],
                'Resolution':
                    '${videoProps['width']} x ${videoProps['height']}',
                'Frame rate': videoProps['avg_frame_rate'] != null
                    ? videoProps['avg_frame_rate'].split('/')[0]
                    : null,
                'Bit rate': videoProps['bit_rate'] != null
                    ? '${(int.parse(videoProps['bit_rate']) / 1000).toStringAsFixed(1)} kbits/sec'
                    : null,
                'Language': videoProps['tags'] != null &&
                        videoProps['tags']['language'] != null
                    ? Constants.langAbbr.keys.firstWhere(
                        (ele) => Constants.langAbbr[ele]!
                            .contains(videoProps['tags']['language']),
                        orElse: () => videoProps['tags']['language'],
                      )
                    : null,
                'Encoding SW': videoProps['tags'] != null
                    ? videoProps['tags']['encoder'] ??
                        videoProps['tags']['ENCODER']
                    : null,
              }
            : {},
        'Stream #2': audioProps.isNotEmpty
            ? {
                'Type': 'Audio',
                'Codec': audioProps['codec_name'] != null
                    ? '${audioProps['codec_name'].toUpperCase()}'
                    : null,
                'Profile': audioProps['profile'],
                'Sample rate': audioProps['sample_rate'] != null
                    ? '${audioProps['sample_rate']} Hz'
                    : null,
                'Channels': audioProps['channel_layout'] != null
                    ? '${audioProps['channel_layout'].substring(0, 1).toUpperCase()}${audioProps['channel_layout'].substring(1)}'
                    : null,
                'Bit rate': audioProps['bit_rate'] != null
                    ? '${(int.parse(audioProps['bit_rate']) / 1000).toStringAsFixed(1)} kbits/sec'
                    : null,
                'Language': audioProps['tags']['language'] != null
                    ? Constants.langAbbr.keys.firstWhere(
                        (ele) => Constants.langAbbr[ele]!
                            .contains(audioProps['tags']['language']),
                        orElse: () => audioProps['tags']['language'],
                      )
                    : null,
                'Encoding SW': audioProps['tags'] != null
                    ? audioProps['tags']['encoder'] ??
                        audioProps['tags']['ENCODER']
                    : null,
              }
            : {},
      });
    }

    return temp;
  }
}