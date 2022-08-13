import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Function fn;
  final String txt;
  const GradientButton({Key? key, required this.fn, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget gradientContainer = Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
      ),
    );

    Widget textButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        primary: Colors.white,
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () => fn(),
      child: Text(txt),
    );

    return (ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          gradientContainer,
          textButton,
        ],
      ),
    ));
  }
}
