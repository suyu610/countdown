import 'package:countdown/config.dart';
import 'package:flutter/material.dart';

Widget MyDrawer() {
  return SafeArea(
    child: ListTileTheme(
      textColor: Colors.black,
      iconColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
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
