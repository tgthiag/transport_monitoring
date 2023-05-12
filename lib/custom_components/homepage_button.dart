import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final String btText;
  final VoidCallback onBtPress;
  final Color btColor;
  final EdgeInsetsGeometry? btPadding;

  const HomePageButton(
      {super.key, required this.btText, required this.onBtPress, required this.btColor, this.btPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child:
        ElevatedButton(
          onPressed: () => onBtPress(),
          style: ElevatedButton.styleFrom(
            padding: btPadding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            backgroundColor: btColor,
            shape: const StadiumBorder(),
          ),
          child: Text(
            btText,
            style: const TextStyle(
              color: Colors.white, fontSize: 14, shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 3.0),
                blurRadius: 10.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],),
          ),
        )
    );
  }

}