import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _view = 'folder';
  String get view => _view;

  String _appbarTitle = 'Folders';
  String get appbarTitle => _appbarTitle;

  final Map<String, dynamic> _appSettings = {};
  Map<String, dynamic> get appSettings => _appSettings;

  changeView(String next) {
    _view = next;
    notifyListeners();
  }

  changeTitle(String title) {
    _appbarTitle = title;
    notifyListeners();
  }

  initializeSettings() {
    _appSettings.addAll({
      'viewMode': 'All folders',
      'layout': 'List',
      'defaultHome': 'Local',
      'theme': 'Light', // Light, Dark, Adaptive, Custom
      'customTheme': null,
      'sort': {'type': 'Title', 'order': 'ascending'},
      'list': {
        'markLastPlayed': true,
        'autoScrollToLastPlayed': false,
        'selectThumbnail': false,
        'floatingButton': true,
        'newTagBasis': 7,
        '.nomedia': true,
        'showHidden': false,
      },
      'player': {
        'style': {
          'preset': 'Default',
          'frame': '0,0,0,136',
          'controls': {
            'color': '255,255,255',
            'highlight': '99,150,255,136',
          },
          'progressBar': {
            'color': 'primary',
            'format': 'Material',
          },
          'progressBarPosition': false,
        },
        'screen': {
          'orientation': 'video',
          'fullscreen': 'auto',
          'buttons': 'auto',
          'brightness': 0,
          'elapsedTime': false,
          'battery': false,
          'cornerOffset': 0,
          'text': '204,204,204',
          'background': '0,0,0,136',
          'placeBottom': false,
          'rotationButton': true,
          'hideDownload': false,
          'displayBattery': false,
          'remainingTime': true,
          'keepScreenOn': false,
          'pauseWhenObstructed': false,
          'showInterface': false,
        },
        'controls': {
          'touchAction': 'toggleInterface',
          'lockMode': 'lock',
          'gestures': {
            'seek': true,
            'zoomPan': false,
            'zoom': true,
            'pan': false,
            'volume': true,
            'brightness': true,
            'doubleTapToPlayPause': false,
            'doubleTapToZoom': false,
            'doubleTapToFFRW': true,
            'playBackSpeed': true,
            'subtitleScroll': true,
            'subtitleUpDown': true,
            'subtitleZoom': true,
          },
          'shortcuts': {
            'screenRotation': true,
            'playBackSpeed': true,
            'backgroundPlay': true,
            'loop': true,
            'mute': true,
            'shuffle': true,
            'equalizer': true,
            'sleepTimer': true,
            'abRepeat': true,
            'nightMode': true,
            'customize': true,
          }
        },
        'navigation': {
          'seekSpeed': 25, // sec/inch
          'fwBwButton': false,
          'moveInterval': 10,
          'prevNextButton': true,
          'displayPosition': true, // while changing
        },
        'doubleTapBack': false, // to close playback screen
        'quickZoom': true,
        'playback': {
          'resume': 'ask',
          'resumeOnlyFirstFile': true,
          'defaultPlaybackSpeed': 100,
          'rememberSelections': true,
          'backToList': false,
          'previewSeeking': true,
          'previewSeekingNet': 'auto',
          'fastSeeking': true,
          'playAlone': true,
          'mediaButtons': true,
          'doublePressNextprev': true,
          'nextPrevFFRW': false,
          'playbackWithButton': false,
          'smartPrevButton': true,
          'suppressErrMsg': false,
          'picNPicPopup': true,
        },
        'backgroundPlay': {
          'pipMode': 'pip',
          'audioBackgroundPlay': true,
          'albumArt': true,
          'smoothSwitch': false,
        },
        'miscellaneous': {
          'videoResizeDelay': null,
          'limitVideoResize': false,
          'offButtonBacklit': true,
          'loadingCircle': true,
          'softwareNavButtons': true,
          'android4': false,
        }
      },
      'decoder': {
        'hardware': {
          'hw+Local': false,
          'hw+Net': false,
          'tryHw': true,
          'tryHw+': true,
          'hw+VideoCodecs': {
            'h.263': true,
            'h.264': true,
            'h.26410Bits': false,
            'h.265': true,
            'h.26510Bits': false,
            'mpeg4': true,
            'vp8': true,
            'vp9': true,
          },
          'hw+AudioCodecs': {
            'aac': false,
            'amrnb': false,
            'amrwb': false,
            'flac': false,
            'g711a': false,
            'g711u': false,
            'gsm': false,
            'mp1': false,
            'mp2': false,
            'mp3': false,
            'opus': false,
            'pcm': false,
            'vorbis': false,
          },
          'hw+OnSw': true,
          'correctRatio': true,
          'callibratePlayback': 0.0,
          'hwAudioTrack': true,
        },
        'software': {
          'swLocal': false,
          'swNet': false,
          'swAudio': false,
          'swAudioLocal': false,
          'swAudioNet': false,
          'cpuCoreLimit': '16bit',
          'speedTricks': false,
        },
        'general': {
          'deInterlace': 'none',
          'customCodec': null,
        }
      },
      'audio': {
        'audioplayer': false,
        'audioOutput': 'auto',
        'volumeBoost': true,
        'systemVolume': true,
        'volumePanel': true,
        'pauseOnHeadsetDisconnected': true,
        'fadeStart': true,
        'fadeSeek': true,
        'audioLanguage': null,
        'audioDelay': 0,
        'bluetoothAudioDelay': 0,
        'passthroughMode': true,
        'audioEqualizer': false,
      },
      'subtitle': {
        'subtitleFolder': '/storage/emulated/0/BoxSubtitles',
        'encoding': 'auto',
        'subtitleLanguage': null,
        'defaultSync': 0.0,
        'syncHw': 0.0,
        'appearance': {
          'text': {
            'font': 'default',
            'size': 24,
            'scale': '100',
            'color': '255,255,255',
            'bold': true,
            'background': false,
            'border': {
              'color': false,
              'scale': '80',
            },
            'strokeRendering': null,
            'shadow': true,
            'fadeOut': true,
            'ssaRendering': false,
            'scriptsRendering': true,
            'ignoreSSAFont': false,
            'ignoreSSABroken': false,
          },
          'layout': {
            'alignment': 'center',
            'bottomMargin': 8,
            'background': false,
            'fitSub': true,
          },
          'fontFolder': '/storage/emulated/0',
        },
        'processing': {
          'italicEffect': false,
          'ltrDirection': true,
        },
      },
      'general': {
        'language': 'default',
        'playMediaLinks': true,
        'userAgent': null,
        'quitButton': false,
        'edit': {
          'allowEditing': true,
          'deleteSub': true,
        },
        'userData': {
          'cacheThumbnails': true,
        },
      },
      'development': {
        'logOperations': false,
      },
      'language': 'default',
      'pipControl': 'prevNext',
    });
  }
}
