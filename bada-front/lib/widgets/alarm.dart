import 'dart:ui';

import 'package:bada/models/alarm_model.dart';
import 'package:bada/widgets/screensize.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Alarm extends StatefulWidget {
  final String createdAt, type;
  const Alarm({
    super.key,
    required this.type,
    required this.createdAt,
  });

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> with TickerProviderStateMixin {
  late final AnimationController _alarmController;

  @override
  void initState() {
    super.initState();
    _alarmController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _alarmController.dispose();
    super.dispose();
  }

  String formatDate(String createdAt) {
    DateTime parsedDate = DateTime.parse(createdAt);
    // Format the date as "yy/MM/dd"
    String formattedDate = DateFormat('yy/MM/dd').format(parsedDate);
    return formattedDate;
  }

  String formatTime(String createdAt) {
    DateTime parsedDate = DateTime.parse(createdAt);
    // Format the time as "h:mm a"
    String formattedTime = DateFormat('h:mm a').format(parsedDate);
    return formattedTime;
  }

  String getIconPath(String type) {
    switch (type) {
      case 'DEPART':
        return 'assets/lottie/departure.json';

      case 'ARRIVE':
        return 'assets/lottie/arrival3.json';

      case 'OFF COURSE':
        return 'assets/lottie/off-road2.json';

      default:
        return 'assets/lottie/arrival2.json';
    }
  }

  String getAlarmContext(String type) {
    switch (type) {
      case 'DEPART':
        return '출발했습니다';

      case 'ARRIVE':
        return '도착했습니다';

      case 'OFF COURSE':
        return '경로 이탈했습니다';

      default:
        return '알림입니다';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _alarmController.reset();
            _alarmController.forward();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff696DFF), width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            width: UIhelper.scaleWidth(context) * 400,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: UIhelper.scaleWidth(context) * 50,
                  height: UIhelper.scaleHeight(context) * 50,
                  child: Lottie.asset(
                    getIconPath(widget.type),
                    controller: _alarmController,
                    onLoaded: ((p0) {
                      _alarmController.duration = p0.duration;
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: UIhelper.scaleWidth(context) * 150,
                  child: Text(getAlarmContext(widget.type)),
                ),
                SizedBox(
                  height: UIhelper.scaleHeight(context) * 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatDate(widget.createdAt)),
                      Text(formatTime(widget.createdAt)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: UIhelper.deviceHeight(context) * 0.001,
        ),
      ],
    );
  }
}

class ForeGroundAlarm extends StatelessWidget {
  final FcmMessage fcmMessage;

  final VoidCallback onConfirm, onClose;

  const ForeGroundAlarm({
    super.key,
    required this.fcmMessage,
    required this.onConfirm,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final title = fcmMessage.notification.title;
    final body = fcmMessage.notification.body;
    final childName = fcmMessage.data.childName;
    final profileUrl = fcmMessage.data.profileUrl;
    final phone = fcmMessage.data.phone;
    final destinationName = fcmMessage.data.destinationName;
    final destinationIcon = fcmMessage.data.destinationIcon;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (profileUrl != '')
              CircleAvatar(
                radius: 40,
                child: Image.network(
                  profileUrl,
                  width: 40,
                ),
              )
            else
              const Text('Placeholder Text'),
            SizedBox(width: UIhelper.deviceWidth(context) * 0.015),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: UIhelper.scaleWidth(context) * 280,
                        child: Text(
                          '"$childName"님께서 $destinationName으로 출발하였습니다!',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: UIhelper.deviceHeight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: onConfirm,
                        child: const Text('확인하기'),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                        onPressed: onClose,
                        child: const Text('닫기'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}