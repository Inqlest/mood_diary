import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:flutter/material.dart';

class StressLevelSlider extends StatefulWidget {
  final String leftLabel;
  final String rightLabel;
  final bool isActive;
  const StressLevelSlider(
      {super.key,
      required this.leftLabel,
      required this.rightLabel,
      required this.isActive});

  @override
  State<StressLevelSlider> createState() => _StressLevelSliderState();
}

class _StressLevelSliderState extends State<StressLevelSlider> {
  double _currentValue = 3.5;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: kGreyColor4,
            spreadRadius: 2,
            blurRadius: 10.8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) {
                  return Container(
                    width: 2,
                    height: 8,
                    color: kGreyColor5,
                  );
                },
              ),
            ),
          ),
          Slider(
            value: _currentValue,
            min: 0,
            max: 6,
            onChanged: widget.isActive
                ? (double value) {
                    setState(
                      () {
                        _currentValue = value;
                      },
                    );
                  }
                : null,
            activeColor: kPrimaryColor,
            inactiveColor: kGreyColor5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.leftLabel, style: subTextStyle),
                Text(widget.rightLabel, style: subTextStyle),
              ],
            ),
          )
        ],
      ),
    );
  }
}
