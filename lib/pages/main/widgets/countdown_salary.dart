import 'package:countdown/components/timer_basic.dart';
import 'package:countdown/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CountdownSalary extends StatelessWidget {
  const CountdownSalary({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerBasic(
      format: CountDownTimerFormat.daysOnly,
      inverted: true,
      endTime: salaryEndTime,
    );
  }
}
