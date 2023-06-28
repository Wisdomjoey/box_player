package com.media.boxplayer

import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import java.util.*

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "boxplayer.videos").setMethodCallHandler {
      call, result ->
      if (call.method == "getVideos") {
          ArrayList<String> videos = findVideos();
  
          if (videos.size() <= 0) {
            result.error("Empty", "No Videos", null);
          } else {
            result.success(videos);
          }
        } else {
          result.notImplemented();
        }
    }
  }

  fun findVideos() {
    HashSet<String> videoItemHashSet = new HashSet();
    String[] projection = {MediaStore.Video.VideoColumns.DATA, MediaStore.Video.Media.DISPLAY_NAME};
    Cursor cursor = getContentResolver().query(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, projection, null, null, null);

    try {
      cursor.moveToFirst();

      do {
        videoItemHashSet.add((cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATA))));
      } while (cursor.moveToNext());

      cursor.close();
    } catch (Exception e) {
      e.printStackTrace();
    }

    ArrayList<String> downloadedList = new ArrayList<>(videoItemHashSet);

    return downloadedList;
  }
}
