package com.media.boxplayer;

import android.os.Bundle;
import android.database.Cursor;
import android.provider.MediaStore;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL_NAME = "boxplayer.videos";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(getFlutterEngine());

    new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL_NAME).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("getVideos")) {
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
    });
  }

  public ArrayList<String> findVideos() {
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
