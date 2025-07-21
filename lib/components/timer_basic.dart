import 'package:countdown/config.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class TimerBasic extends StatelessWidget {
  final CountDownTimerFormat format;
  final bool inverted;
  final DateTime endTime;
  const TimerBasic({
    required this.format,
    required this.endTime,
    this.inverted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      format: format,
      endTime: endTime,
      onEnd: () {},
      timeTextStyle: TextStyle(
        color: (inverted) ? enableColor : CupertinoColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 40,
        fontFamily: "huawei",
        fontFeatures: <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      colonsTextStyle: TextStyle(
        color: (inverted) ? enableColor : CupertinoColors.white,
        fontWeight: FontWeight.w300,
        fontSize: 40,
        fontFamily: "huawei",
        fontFeatures: <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      descriptionTextStyle: TextStyle(
        color: (inverted) ? enableColor : CupertinoColors.white,
        fontSize: 10,
        fontFamily: "huawei",
        fontFeatures: <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      spacerWidth: 0,
      daysDescription: "days",
      hoursDescription: "hours",
      minutesDescription: "minutes",
      secondsDescription: "seconds",
    );
  }
}
