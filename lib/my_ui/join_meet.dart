import 'package:flutter/material.dart';
import 'package:video_project/my_code/auth_code.dart';
import 'package:video_project/my_code/jetsi_code.dart';

class JoinMeetUI extends StatefulWidget {
  JoinMeetUI({super.key});

  @override
  State<JoinMeetUI> createState() => _JoinMeetUIState();
}

class _JoinMeetUIState extends State<JoinMeetUI> {
  late TextEditingController meetingID;

  late TextEditingController userName;
  final AuthCode _authCode = AuthCode();
  final JitsiCode _jitsiCode = JitsiCode();

  JoinMeetingButton() {
    _jitsiCode.CreateMeet(meetingID.text);
  }

  @override
  void initState() {
    meetingID = TextEditingController(text: "");
    userName = TextEditingController(text: _authCode.user!.displayName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black26,
        title: Text(
          "Join Meeting",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: meetingID,
            keyboardType: TextInputType.number,
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(179, 67, 60, 60),
              filled: true,
              hintText: "Enter Meeting ID",
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: userName,
            keyboardType: TextInputType.name,
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Color.fromARGB(179, 67, 60, 60),
              filled: true,
              hintText: "User Name",
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            child: Text(
              "Join",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            onTap: () => JoinMeetingButton(),
          )
        ],
      ),
    );
  }
}
