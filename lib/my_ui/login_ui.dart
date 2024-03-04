import 'package:flutter/material.dart';
import 'package:video_project/my_code/auth_code.dart';
import 'package:video_project/my_tools/colors.dart';
import 'package:video_project/my_ui/home_ui.dart';

class LoginUI extends StatelessWidget {
  final AuthCode _authCode = AuthCode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enjoy Your Meetings!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset("assets/images/LoginScreen.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyButtonColor,
                  foregroundColor: Color.fromARGB(255, 0, 67, 251),
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                // Sign in with Google when the button is clicked
                await _authCode.SignInWithGoogle();

                // After signing in, navigate to HomeUI
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeUI(),
                  ),
                );
              },
              child: Text(
                "Join Now Or Login",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
