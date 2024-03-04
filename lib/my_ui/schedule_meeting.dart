import 'package:flutter/material.dart';
import 'package:video_project/my_code/firestore_db.dart';
import 'package:video_project/my_ui/scheduled_ui.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  @override
  _ScheduleMeetingScreenState createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  TextEditingController _meetingNameController = TextEditingController();
  TextEditingController _meetingDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Meeting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _meetingNameController,
            decoration: InputDecoration(labelText: 'Meeting Name'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _meetingDateController,
            decoration: InputDecoration(labelText: 'Meeting Date'),
            onTap: () async {
              // Implement logic to show date picker
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (selectedDate != null) {
                _meetingDateController.text =
                    selectedDate.toIso8601String(); // Format date as needed
              }
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final meetingName = _meetingNameController.text;
              final meetingDate = DateTime.parse(_meetingDateController.text);
              await FireStoreDB().scheduleMeeting(meetingName, meetingDate);

              // Show a message that the meeting is scheduled
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Meeting Scheduled'),
                    content: Text('Your meeting has been scheduled.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          // Navigate to the Scheduled Meetings UI
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScheduledUI()),
                          );
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Schedule Meeting'),
          ),
        ]),
      ),
    );
  }
}
