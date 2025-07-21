import 'package:countdown/components/timer_basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class Countdown extends StatelessWidget {
  CountDownTimerFormat format;
  DateTime endTime;
  String title;
  Color titleColor;
  Countdown({
    super.key,
    required this.format,
    required this.endTime,
    required this.title,
    this.titleColor = const Color(0xffA5D6A7),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontFamily: "huawei", color: titleColor)),
        TimerBasic(
          format: format,
          inverted: true,
          endTime: endTime,
        ),
      ],
    );
  }
}
