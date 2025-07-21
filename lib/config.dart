import 'dart:ui';

import 'package:countdown/style/color_palette.dart';

DateTime endTime = DateTime.now().copyWith(
  hour: 17,
  minute: 30,
  second: 0,
  millisecond: 0,
  microsecond: 0,
);
// 需要判断一下，如果今天已经超过10号，则直接显示下个月的10号，否则显示这个月的10号
DateTime salaryEndTime = DateTime.now().day >= 10
    ? DateTime.now().copyWith(
        day: 10,
        month: DateTime.now().month + 1,
      )
    : DateTime.now().copyWith(
        day: 10,
        month: DateTime.now().month,
      );

DateTime examEndTime = DateTime.now().copyWith(
  day: 9,
  month: 11,
);

DateTime startTime = DateTime.now().copyWith(
  hour: 08,
  minute: 30,
  second: 0,
  millisecond: 0,
  microsecond: 0,
);
List<Color> colorPalette = colorPaletteGreen;
Color disableColor = colorPalette[1];
Color enableColor = colorPalette[5];
int count = 9 * 60;
