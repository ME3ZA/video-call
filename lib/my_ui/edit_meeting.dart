import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_project/my_code/firestore_db.dart';
import 'package:video_project/my_ui/scheduled_ui.dart';

class EditMeetingScreen extends StatefulWidget {
  final String meetingId;
  final String currentMeetingName;
  final DateTime currentMeetingDate;

  EditMeetingScreen({
    required this.meetingId,
    required this.currentMeetingName,
    required this.currentMeetingDate,
  });

  @override
  _EditMeetingScreenState createState() => _EditMeetingScreenState();
}

class _EditMeetingScreenState extends State<EditMeetingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _meetingNameController = TextEditingController();
  DateTime _meetingDate = DateTime.now(); // Initialize with current date/time

  @override
  void initState() {
    super.initState();
    _meetingNameController.text = widget.currentMeetingName;
    _meetingDate = widget.currentMeetingDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Meeting'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _meetingNameController,
                decoration: InputDecoration(labelText: 'Meeting Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a meeting name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Meeting Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: _meetingDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        _meetingDate = pickedDate;
                      });
                    }
                  });
                },
                child: Text(
                  DateFormat.yMMMMd().add_jm().format(_meetingDate),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, update meeting details
                    FireStoreDB().editMeeting(
                      widget.meetingId,
                      _meetingNameController.text,
                      _meetingDate,
                    );

                    // Show SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Changes saved successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    // Pop the current route (EditMeetingScreen)
                    Navigator.pop(context);

                    // Push the ScheduledUI as a new route
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduledUI()),
                    );
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
