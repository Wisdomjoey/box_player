import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'PROVIDERS/app_provider.dart';
import 'PROVIDERS/video_provider.dart';
import 'UI/screens/folders_screen.dart';
import 'UI/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Constants.bottomBar));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
      ],
      child: MaterialApp(
        title: 'Box Player',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Constants.darkPrimary,
            primarySwatch: Colors.green,
            primaryColor: Colors.green,
            scrollbarTheme: const ScrollbarThemeData(
                trackColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 59, 59, 59)),
                thumbColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 97, 97, 97)),
                minThumbLength: 50),
            checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                side: const BorderSide(color: Constants.textColor, width: 2)),
            tooltipTheme: TooltipThemeData(
                textStyle: const TextStyle(color: Colors.black),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(3)))),
        home: const FoldersScreen(),
      ),
    );
  }
}
