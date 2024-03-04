import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void addMeetingtoDB(String meetingName) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("meetings")
          .add({"meetingname": meetingName, "meetingdate": DateTime.now()});
    } catch (e) {}
  }

  Future<void> scheduleMeeting(String meetingName, DateTime meetingDate) async {
    try {
      await _firebaseFirestore
          .collection("meetings")
          .doc(_auth.currentUser!.uid)
          .collection("scheduled")
          .add({
        "meetingname": meetingName,
        "meetingdate": meetingDate,
      });
    } catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<List<DocumentSnapshot>> getScheduledMeetings() async {
    try {
      var querySnapshot = await _firebaseFirestore
          .collection("meetings")
          .doc(_auth.currentUser!.uid)
          .collection("scheduled")
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print(e);
      // Handle error
      return [];
    }
  }

  Future<void> editMeeting(
      String meetingId, String newMeetingName, DateTime newMeetingDate) async {
    try {
      await _firebaseFirestore
          .collection("meetings")
          .doc(_auth.currentUser!.uid)
          .collection("scheduled")
          .doc(meetingId)
          .update({
        "meetingname": newMeetingName,
        "meetingdate": newMeetingDate,
      });
    } catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<void> deleteMeeting(String meetingId) async {
    try {
      await _firebaseFirestore
          .collection("meetings")
          .doc(_auth.currentUser!.uid)
          .collection("scheduled")
          .doc(meetingId)
          .delete();
    } catch (e) {
      print(e);
      // Handle error
    }
  }
}
