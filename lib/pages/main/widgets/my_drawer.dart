import 'package:countdown/config.dart';
import 'package:flutter/material.dart';

Widget MyDrawer(BuildContext context) {
  return SafeArea(
    child: ListTileTheme(
      textColor: Colors.black,
      iconColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          GestureDetector(
            onTap: () async {
              // var result = await showBoardDateTimePicker(
              //     context: context,
              //     pickerType: DateTimePickerType.time,
              //     options: BoardDateTimeOptions(activeColor: colorPalette[4]));
              // snackbar
            },
            child: Row(
              children: [
                Text("下班时间",
                    style: TextStyle(fontFamily: "huawei"),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text(
                'uuorb.com',
                style: TextStyle(color: colorPalette[4], fontFamily: "huawei"),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
