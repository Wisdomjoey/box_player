import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../UI/utils/constants.dart';

class VideoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _videoDirs = [];
  List<Map<String, dynamic>> get videoDirs => _videoDirs;

  String homePath = '/storage/emulated/0/';

  Future initializeVideoDirs() async {
    List<Directory>? paths = await getExternalStorageDirectories();

    try {
      homePath = paths![0].path.split('Android')[0];
      Directory storageDir = Directory(homePath);

      List<FileSystemEntity> entities = storageDir.listSync();

      for (FileSystemEntity element in entities) {
        if (element.path != '${homePath}Android') {
          if (element is File &&
              Constants.videoFormats.contains(path.extension(element.path))) {
            sortVideoPath(element.path);
          } else if (element is Directory) {
            getAllFiles(element.path);
          }
        }
      }

      getAllFiles('${homePath}Android/media');

      print(_videoDirs);
      // for (var ele in videos) {
      //   String folderName = path.basename(path.dirname(ele.path));

      //   if (directories.isEmpty) {
      //     directories.add({
      //       'folder': folderName == '0' ? 'Internal Storage' : folderName,
      //       'videoPaths': <String>[ele.path],
      //       'videoInfo': '',
      //     });
      //   } else {
      //     for (int i = 0; i < directories.length; i++) {
      //       if (directories[i]['folder'] == folderName ||
      //           (folderName == '0' &&
      //               directories[i]['folder'] == 'Internal Storage')) {
      //         directories[i] = {
      //           ...directories[i],
      //           'videoPaths': [...directories[i]['videoPaths'], ele.path]
      //         };
      //       } else {
      //         directories.add({
      //           'folder': folderName == '0' ? 'Internal Storage' : folderName,
      //           'videoPaths': <String>[ele.path],
      //           'videoInfo': '',
      //         });
      //       }
      //     }
      //   }
      // }

      // _videoDirs = directories;
      // notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  sortVideoPath(String vPath) {
    String hPath = path.dirname(vPath);
    List<Map<String, dynamic>> match = _videoDirs
        .where((ele) => ele['path'].contains(path.dirname(vPath)))
        .toList();

    if (match.isNotEmpty) {
      _videoDirs[_videoDirs.indexOf(match[0])] = {
        ...match[0],
        'videos': [...match[0]['videos'], vPath]
      };
    } else {
      _videoDirs.add({
        'path': '${hPath[0].toUpperCase()}${hPath.substring(1)}',
        'pathName':
            hPath == '$homePath/' ? 'Internal Memory' : path.basename(hPath),
        'videos': [vPath]
      });
    }
  }

  getAllFiles(String dirPath) {
    Directory dir = Directory(dirPath);
    List<FileSystemEntity> dirs = dir.listSync(recursive: true);

    for (FileSystemEntity ele in dirs) {
      if (ele is File &&
          Constants.videoFormats.contains(path.extension(ele.path))) {
        sortVideoPath(ele.path);
      }
    }
  }
}
