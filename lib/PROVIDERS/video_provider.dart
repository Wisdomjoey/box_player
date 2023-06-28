import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:flutter/services.dart';
import 'package:isolate_handler/isolate_handler.dart';

import '../UTILS/file_utils.dart';

enum Status { uninitialized, processing, finished }

class VideoProvider extends ChangeNotifier {
  final List<String> _videos = [];
  List<String> get videos => _videos;

  final List<Map<String, dynamic>> _folderDirs = [];
  List<Map<String, dynamic>> get folderDirs => _folderDirs;

  final Map<String, Map<String, Map<String, dynamic>>> _videoInfos = {};
  Map<String, Map<String, Map<String, dynamic>>> get videoInfos => _videoInfos;

  final List<String> _selected = [];
  List<String> get selected => _selected;

  Status _status = Status.uninitialized;
  Status get status => _status;

  String _fileRoute = 'Home';
  String get fileRoute => _fileRoute;

  addSelected(String name) {
    _selected.add(name);
    notifyListeners();
  }

  removeSelected(String name) {
    _selected.remove(name);
    notifyListeners();
  }

  clearSelected() {
    _selected.clear();
    notifyListeners();
  }

  changeFileRoute(String route) {
    _fileRoute += route;
    notifyListeners();
  }

  Future fetchMedia() async {
    _status = Status.processing;
    notifyListeners();

    final data = await fetchVideos();
    final dirs = await FileUtils.sortVideoPaths([...data]);

    _videos.addAll([...data]);
    _folderDirs.addAll(dirs);

    _status = Status.finished;
    notifyListeners();

    getVideoInfos([...data]);
  }

  fetchVideos() async {
    const platform = MethodChannel('boxplayer.videos');
    try {
      List vids = await platform.invokeMethod('getVideos');

      return vids;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getVideoInfos(List<String> data) async {
    List<Map<dynamic, dynamic>?> mediaProps = [];

    for (String ele in data) {
      final mediaInfo = await FFprobeKit.getMediaInformation(ele);

      mediaProps.add(mediaInfo.getMediaInformation()?.getAllProperties());

      mediaInfo.cancel();
    }

    if (mediaProps.isNotEmpty) {
      handleFilesWithIsolate(data, mediaProps);
    }
  }

  // static getStorageDirs(Map<String, dynamic> context) async {
  //   try {
  //     HandledIsolateMessenger messenger = HandledIsolate.initialize(context);

  //     String home =
  //         (await getExternalStorageDirectory())!.path.split('Android')[0];
  //     Directory homeDir = Directory(home);
  //     List<FileSystemEntity> homeDirs = homeDir.listSync();
  //     List<String> files = [];
  //     List<String> dirs = [];

  //     for (var ele in homeDirs) {
  //       if (ele.path.contains('Android')) {
  //         dirs.add('${ele.path}/media');
  //       } else if (ele is File &&
  //           Constants.videoFormats.contains(path.extension(ele.path))) {
  //         files.add(ele.path);
  //       } else if (ele is Directory) {
  //         dirs.add(ele.path);
  //       }
  //     }

  //     final send = IsolateNameServer.lookupPortByName('getStorageDirs_1');

  //     if (send != null) {
  //       send.send({'dirs': dirs, 'files': files});
  //     }

  //     messenger.send('done');
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  // searchDirWithIsolate(String dirPath, int id) async {
  //   isolateCount++;
  //   IsolateHandler isolate = IsolateHandler();

  //   isolate.spawn<Map<String, dynamic>>(
  //     searchDir,
  //     name: 'searchDir$id',
  //     onReceive: (message) {
  //       debugPrint(message['msg']);
  //       isolate.kill('searchDir$id');
  //     },
  //     onInitialized: () =>
  //         isolate.send({'dirPath': dirPath, 'id': id}, to: 'searchDir$id'),
  //   );

  //   ReceivePort port = ReceivePort();

  //   IsolateNameServer.registerPortWithName(port.sendPort, 'searchDir_$id');
  //   port.listen((data) async {
  //     isolateCount--;

  //     debugPrint('GOTTEN FILES IN DIR');
  //     _videos.addAll(data);

  //     List<Map<dynamic, dynamic>?> mediaProps = [];

  //     for (String ele in data) {
  //       final mediaInfo = await FFprobeKit.getMediaInformation(ele);

  //       mediaProps.add(mediaInfo.getMediaInformation()?.getAllProperties());

  //       mediaInfo.cancel();
  //     }

  //     if (mediaProps.isNotEmpty) {
  //       handleFilesWithIsolate(data, id, mediaProps);
  //     }

  //     port.close();
  //     IsolateNameServer.removePortNameMapping('searchDir_$id');
  //   });
  // }

  // static searchDir(Map<String, dynamic> context) async {
  //   try {
  //     HandledIsolateMessenger messenger = HandledIsolate.initialize(context);

  //     messenger.listen((msg) {
  //       Directory dir = Directory(msg['dirPath']);
  //       List<String> files = dir
  //           .listSync(recursive: true)
  //           .where((ele) =>
  //               Constants.videoFormats.contains(path.extension(ele.path)))
  //           .map((e) => e.path)
  //           .toList();

  //       final send =
  //           IsolateNameServer.lookupPortByName('searchDir_${msg['id']}');

  //       if (send != null) {
  //         send.send(files);
  //       }

  //       messenger.send({'msg': 'done'});
  //     });
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  handleFilesWithIsolate(
      List<String> filePaths, List<Map<dynamic, dynamic>?> mediaProps) {
    IsolateHandler isolate = IsolateHandler();

    isolate.spawn<Map<String, dynamic>>(
      FileUtils.handleFiles,
      name: 'handleFiles',
      onReceive: (message) {
        debugPrint(message['msg']);
        isolate.kill('handleFiles');
      },
      onInitialized: () => isolate.send(
          {'filePaths': filePaths, 'mediaProps': mediaProps},
          to: 'handleFiles'),
    );

    ReceivePort port = ReceivePort();

    IsolateNameServer.registerPortWithName(port.sendPort, 'handleFiles_');
    port.listen((data) async {
      debugPrint('FILES HAS BEEN SORTED');

      _videoInfos.addAll(data);

      port.close();
      IsolateNameServer.removePortNameMapping('handleFiles_1');
    });
  }
}
