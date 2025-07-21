import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:countdown/config.dart';
import 'package:countdown/pages/main/widgets/countdown.dart';
import 'package:countdown/pages/main/widgets/heatmap.dart';
import 'package:countdown/pages/main/widgets/my_drawer.dart';
import 'package:countdown/pages/main/widgets/setting_btn.dart';
import 'package:countdown/storage/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  RxList<HeatMapItem> itemList =
      List.generate(count, (index) => HeatMapItem(disableColor)).obs;

  late Timer timer;
  RxInt githubStarCount = 0.obs;
  RxInt bilibiliFansCount = 0.obs;

  AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  void getGithubStarCount() async {
    bilibiliFansCount.value = 0;
    githubStarCount.value = 0;
    var url = Uri.https("uuorb.com", "/api/github/star");
    var response = await http.get(url);
    // 转 json

    githubStarCount.value = int.tryParse(response.body) ?? 0;

    url = Uri.https("uuorb.com", "/api/fans/bilibili");
    response = await http.get(url);

    // 转 json
    bilibiliFansCount.value = int.tryParse(response.body) ?? 0;

    // local count
    int localGithubCount = SettingStorageUtil.githubCount();
    int localBilibiliCount = SettingStorageUtil.bilibiliCount();

    if (localGithubCount == 0) {
      SettingStorageUtil.setGithubCount(githubStarCount.value);
    }
    if (localBilibiliCount == 0) {
      SettingStorageUtil.setBilibiliCount(bilibiliFansCount.value);
    }

    // 判断是否需要通知
    if (githubStarCount.value > localGithubCount) {
      notify("Github", "Star数量: ${githubStarCount.value}");
      SettingStorageUtil.setGithubCount(githubStarCount.value);
    }
    if (bilibiliFansCount.value > localBilibiliCount) {
      notify("BILIBILI", "Bilibili粉丝数: ${bilibiliFansCount.value}");
      SettingStorageUtil.setBilibiliCount(bilibiliFansCount.value);
    }
  }

  void notify(title, body) {
    if (Platform.isWindows) {
      LocalNotification notification = LocalNotification(
        title: title,
        body: body,
      );

      notification.show();
    }
  }

  void updateHeatMapItem() {
    // 计算当前时间，并更新热力图
    DateTime now = DateTime.now();
    DateTime start = DateTime.now().copyWith(
      hour: 08,
      minute: 30,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    salaryEndTime = DateTime.now().day >= 10
        ? DateTime.now().copyWith(
            day: 10,
            month: DateTime.now().month + 1,
          )
        : DateTime.now().copyWith(
            day: 10,
            month: DateTime.now().month,
          );

    int minutesPassed = max(0, now.difference(start).inMinutes);
    minutesPassed = min(minutesPassed, count);
    // 每经过1分钟，填充1个格子
    MainController mainController = Get.find<MainController>();
    for (int i = 0; i < minutesPassed; i++) {
      mainController.itemList[i].color = enableColor;
    }
    mainController.itemList.refresh();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TrayListener {
  final TrayManager _trayManager = TrayManager.instance;

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();

    return AdvancedDrawer(
        openRatio: .3,
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorPalette[1],
                colorPalette[0],
              ],
            ),
          ),
        ),
        controller: mainController.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: MyDrawer(),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 40,
                      child: SettingBtn(),
                    ),
                    Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.network(
                                    "https://uuorb.com/img/social/github.svg",
                                    colorFilter: ColorFilter.mode(
                                        colorPalette[4], BlendMode.srcIn),
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Obx(() => (Text(
                                      mainController.githubStarCount.value
                                          .toString(),
                                      style: TextStyle(
                                          color: colorPalette[4],
                                          fontFamily: "huawei"),
                                    ))),
                                SizedBox(width: 10),
                                SvgPicture.network(
                                  "https://uuorb.com/img/social/bilibili.svg",
                                  colorFilter: ColorFilter.mode(
                                      colorPalette[4], BlendMode.srcIn),
                                  // color: colorPalette[4],
                                  height: 16,
                                  width: 16,
                                ),
                                SizedBox(width: 2),
                                Obx(() => (Text(
                                      mainController.bilibiliFansCount.value
                                          .toString(),
                                      style: TextStyle(
                                          color: colorPalette[
                                              4], // Color(0xffe3b341),
                                          fontFamily: "huawei"),
                                    ))),
                              ],
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                mainController.getGithubStarCount();
                              },
                              child: Icon(
                                Icons.refresh,
                                color: colorPalette[2],
                                size: 14,
                              ),
                            )
                          ],
                        )),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HeatMap(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Countdown(
                              title: "下班倒计时",
                              endTime: endTime,
                              format: CountDownTimerFormat.hoursMinutesSeconds,
                            ),
                            Countdown(
                              title: "发工资剩余天数",
                              endTime: salaryEndTime,
                              format: CountDownTimerFormat.daysOnly,
                            ),
                            Countdown(
                              title: "考试倒计时",
                              endTime: examEndTime,
                              format: CountDownTimerFormat.daysOnly,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  void onTrayIconRightMouseDown() async {
    await _trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    windowManager.setFullScreen(true);
  }

  @override
  void onTrayIconMouseDown() async {
    await windowManager.isVisible()
        ? windowManager.hide()
        : windowManager.show();
  }

  // 屏幕尺寸变化

  Future<void> initTray() async {
    await _trayManager.setIcon(
      'assets/icons/logo.ico',
    );
    _trayManager.setToolTip('下班倒计时');

    _trayManager.addListener(this);
  }

  @override
  void initState() {
    super.initState();
    Get.put(MainController());

    MainController mainController = Get.find<MainController>();
    // 每隔10秒钟，更新一次数据
    mainController.updateHeatMapItem();
    mainController.getGithubStarCount();

    mainController.timer = Timer.periodic(Duration(minutes: 1), (timer) {
      mainController.updateHeatMapItem();
      mainController.getGithubStarCount();
    });
    if (Platform.isWindows) {
      initTray();
    }
  }

  @override
  void dispose() {
    _trayManager.removeListener(this);
    super.dispose();
  }
}
