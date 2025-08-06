import 'dart:io';

import 'package:countdown/pages/main/view.dart';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initWindowsManager();

  await localNotifier.setup(
    appName: '打工倒计时',
    shortcutPolicy: ShortcutPolicy.requireCreate,
  );

  runApp(_myApp());
}

initWindowsManager() async {
  if (Platform.isWindows || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        fullScreen: false,
        center: true,
        size: Size(800, 550),
        backgroundColor: Color.fromARGB(255, 44, 26, 26),
        skipTaskbar: false,
        alwaysOnTop: false, // 置顶
        titleBarStyle: TitleBarStyle.normal,
        title: "打工倒计时");

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

Widget _myApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/main": (context) => const MainPage(),
    },
    initialRoute: "/main",
  );
}
