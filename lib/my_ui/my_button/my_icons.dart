import 'package:flutter/material.dart';

class MyIcons extends StatelessWidget {
  final IconData icon;
  final String txt;
  final VoidCallback onClick;
  const MyIcons(
      {super.key,
      required this.icon,
      required this.txt,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClick,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(blurRadius: 5)]),
            child: Icon(
              icon,
              size: 50,
            ),
          ),
        ),
        Text(txt),
      ],
    );
  }
}
