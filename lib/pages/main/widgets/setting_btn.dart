import 'package:countdown/config.dart';
import 'package:countdown/pages/main/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingBtn extends StatelessWidget {
  const SettingBtn({super.key});

  @override
  Widget build(Object context) {
    MainController mainController = Get.find();

    return GestureDetector(
      onTap: () {
        mainController.advancedDrawerController.toggleDrawer();
      },
      child: Icon(
        Icons.settings,
        color: colorPalette[3],
        size: 26,
      ),
    );
  }
}
