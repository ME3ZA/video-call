import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_project/my_code/jetsi_code.dart';
import 'package:video_project/my_ui/join_meet.dart';
import 'package:video_project/my_ui/my_button/my_icons.dart';
import 'package:video_project/my_ui/schedule_meeting.dart';

class MeetingsUI extends StatefulWidget {
  @override
  State<MeetingsUI> createState() => _MeetingsUIState();
}

class _MeetingsUIState extends State<MeetingsUI> {
  //const MeetingsUI({super.key});
  final JitsiCode _jitsiCode = JitsiCode();

  CreateNewMeeting() {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiCode.CreateMeet(roomName);
  }

  JoinMeeting() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => JoinMeetUI(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyIcons(
          icon: Icons.videocam,
          txt: 'New Meeting',
          onClick: () {
            CreateNewMeeting();
          },
        ),
        MyIcons(
          icon: Icons.add_box_rounded,
          txt: 'Join Meeting',
          onClick: JoinMeeting,
        ),
        MyIcons(
          icon: Icons.calendar_today,
          txt: 'Schedule',
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScheduleMeetingScreen()),
            );
          },
        ),
      ],
    ));
  }
}
