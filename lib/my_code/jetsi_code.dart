import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_project/my_code/auth_code.dart';
import 'package:video_project/my_code/firestore_db.dart';

class JitsiCode {
  final AuthCode _authCode = AuthCode();
  final FireStoreDB _fireStoreDB = FireStoreDB();

  CreateMeet(
    String roomName,
  ) {
    _fireStoreDB.addMeetingtoDB(roomName);
    var options = JitsiMeetConferenceOptions(
      room: roomName,
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "subject": "",
      },
      featureFlags: {"unsaferoomwarning.enabled": false},
      userInfo: JitsiMeetUserInfo(
          displayName: _authCode.user!.displayName,
          email: _authCode.user!.email,
          avatar: _authCode.user!.photoURL),
    );
    JitsiMeet().join(options);
  }
}
