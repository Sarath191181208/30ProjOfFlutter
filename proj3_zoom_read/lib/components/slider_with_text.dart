import 'package:flutter/material.dart';

class SliderWithText extends StatefulWidget {
  final String txt;
  final Function fn;
  final double initialVal;
  final double maxVal;
  final double minVal;
  const SliderWithText(
      {Key? key,
      required this.txt,
      required this.fn,
      required this.initialVal,
      required this.maxVal,
      required this.minVal})
      : super(key: key);

  @override
  State<SliderWithText> createState() => _SliderWithTextState();
}

class _SliderWithTextState extends State<SliderWithText> {
  double? val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(widget.txt),
          Expanded(
            child: Slider(
              max: widget.maxVal,
              min: widget.minVal,
              onChanged: (double value) {
                widget.fn(value);
                setState(() {
                  val = value;
                });
              },
              value: val ?? widget.initialVal,
            ),
          )
        ],
      ),
    );
  }
}
