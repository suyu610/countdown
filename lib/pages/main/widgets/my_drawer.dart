import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:countdown/config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget MyDrawer(BuildContext context) {
  return SafeArea(
    child: ListTileTheme(
      textColor: Colors.black,
      iconColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // 得遍历一下taskList

          Spacer(),
          GestureDetector(
            onTap: () async {
              DateTime? result = await showBoardDateTimePicker(
                  context: context,
                  pickerType: DateTimePickerType.time,
                  options: BoardDateTimeOptions(activeColor: colorPalette[4]));

              if (result != null) {
                // 只要time
                print("hour：${result.hour}; minute：${result.minute}");
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("下班时间设置",
                    style: TextStyle(fontFamily: "huawei"),
                    textAlign: TextAlign.center),
                Icon(Icons.arrow_forward_ios_outlined, size: 12)
              ],
            ),
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
            child: GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://www.uuorb.com"));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Text(
                  'uuorb.com',
                  style:
                      TextStyle(color: colorPalette[4], fontFamily: "huawei"),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
