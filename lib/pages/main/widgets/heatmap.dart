import 'package:countdown/pages/main/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeatMap extends StatelessWidget {
  const HeatMap({super.key});
  // 获取屏幕尺寸
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isSmall = width < 400;
    return SizedBox(
      height: 300,
      width: width * 0.9,
      child: Obx(
        () => GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: isSmall ? 24 : 40,
          // 每隔2分钟，走一个圆圈
          children: Get.find<MainController>()
              .itemList
              .where((item) =>
                  Get.find<MainController>().itemList.indexOf(item) %
                      (isSmall ? 2 : 1) ==
                  0)
              .map((item) => item.toItem())
              .toList(),
        ),
      ),
    );
  }
}

class HeatMapItem {
  Color color;
  HeatMapItem(this.color);
  Widget toItem() {
    return Container(
      margin: EdgeInsets.all(2.5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
    );
  }
}
