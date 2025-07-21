import 'package:countdown/config.dart';
import 'package:countdown/pages/main/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefreshBtn extends StatelessWidget {
  const RefreshBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: GestureDetector(
        onTap: () {
          MainController controller = Get.find();
          controller.updateHeatMapItem();
          // snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: enableColor,
              content: Text(
                "刷新成功",
                style: TextStyle(fontFamily: "huawei", color: Colors.white),
              ),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Icon(Icons.refresh, color: enableColor, size: 34),
      ),
    );
  }
}
