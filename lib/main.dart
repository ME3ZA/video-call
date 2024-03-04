import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_project/my_code/auth_code.dart';
import 'package:video_project/my_tools/colors.dart';
import 'package:video_project/my_ui/home_ui.dart';
import 'package:video_project/my_ui/login_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Video App",
    options: FirebaseOptions(
      apiKey: "Api key here",
      appId: "App id here",
      messagingSenderId: "Messaging sender id here",
      projectId: "project id here",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyVideoApp',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: MyBackGroundColor),
      home: StreamBuilder(
          stream: AuthCode().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return HomeUI();
            }
            return LoginUI();
          }),
    );
  }
}
