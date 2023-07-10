import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../UI/utils/constants.dart';

class SystemUtils {
  static setSystemUIOverlay() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Constants.bottomBar));
  }

  static Future resetSystemUIMode() async {
    // await SystemChrome.restoreSystemUIOverlays();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    setSystemUIOverlay();
  }

  static Future setFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  static Future setLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static resetOrientation() async {
    await SystemChrome.setPreferredOrientations([]);
  }
}
