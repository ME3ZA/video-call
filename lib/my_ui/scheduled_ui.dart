import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_project/my_code/firestore_db.dart';
import 'package:intl/intl.dart';
import 'package:video_project/my_ui/edit_meeting.dart'; // Import the intl package

class ScheduledUI extends StatefulWidget {
  @override
  _ScheduledUIState createState() => _ScheduledUIState();
}

class _ScheduledUIState extends State<ScheduledUI> {
  final FireStoreDB _fireStoreDB = FireStoreDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Meetings'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _fireStoreDB.getScheduledMeetings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No scheduled meetings'));
          } else {
            List<DocumentSnapshot> meetings = snapshot.data!;
            return ListView.builder(
              itemCount: meetings.length,
              itemBuilder: (context, index) {
                var meetingData =
                    meetings[index].data() as Map<String, dynamic>;
                var meetingId = meetings[index].id;
                var meetingName = meetingData['meetingname'];
                var meetingDate = meetingData['meetingdate'].toDate();
                var formattedDate =
                    DateFormat.yMMMMd().add_jm().format(meetingDate);

                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Meeting Name:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(meetingName),
                        SizedBox(height: 5),
                        Text(
                          'Meeting Date:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(formattedDate),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMeetingScreen(
                                      meetingId: meetingId,
                                      currentMeetingName: meetingName,
                                      currentMeetingDate: meetingDate,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Delete the meeting and update UI
                                _fireStoreDB.deleteMeeting(meetingId);
                                setState(() {
                                  // Remove the meeting from the list
                                  meetings.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
