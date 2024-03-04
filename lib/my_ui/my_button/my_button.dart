import 'package:flutter/material.dart';
import 'package:video_project/my_tools/colors.dart';

class MyButton extends StatelessWidget {
  final String txt;
  final VoidCallback onClick;
  const MyButton({super.key, required this.txt, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: onClick,
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: MyButtonColor,
              foregroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ));
  }
}
