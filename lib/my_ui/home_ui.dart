import 'package:flutter/material.dart';
import 'package:video_project/my_ui/login_ui.dart';
import 'package:video_project/my_ui/meetings_ui.dart'; // Import your MeetingsUI widget
import 'package:video_project/my_ui/scheduled_ui.dart'; // Import your ScheduledUI widget
import 'package:video_project/my_ui/contacts_ui.dart'; // Import your ContactsUI widget
import 'package:video_project/my_code/auth_code.dart'; // Import your AuthCode for sign out

class HomeUI extends StatefulWidget {
  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int pageIndex = 0;
  final myPages = [
    MeetingsUI(),
    ScheduledUI(),
    ContactsUI(
      username: '',
    ),
  ];

  final AuthCode _authCode = AuthCode(); // Initialize AuthCode

  // Function to handle sign out
  void _signOut() {
    _authCode.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) =>
          LoginUI(), // Navigate to login screen after sign out
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black26,
        title: Text(
          "M3 Meetings",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: myPages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 3) {
            // If sign out item is tapped
            _signOut(); // Call sign out function
          } else {
            setState(() {
              pageIndex = index;
            });
          }
        },
        currentIndex: pageIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: "New Meeting",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: "Meetings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout), // Add sign out icon
            label: "Sign Out",
          ),
        ],
      ),
    );
  }
}
