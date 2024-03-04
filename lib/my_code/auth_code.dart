import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authChanges => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  SignInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User? user = userCredential.user;

    if (user != null) {
      if (userCredential.additionalUserInfo!.isNewUser) {
        _firestore.collection("users").doc(user.uid).set({
          'username': user.displayName,
          'uid': user.uid,
          'image': user.photoURL,
        });
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut(); // Sign out from Google as well
  }

  Future<User?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return user;
      } else {
        // If the user is null, sign out from Google as well
        await GoogleSignIn().signOut();
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during fetching the current user
      print('Error fetching current user: $e');
      return null;
    }
  }
}
