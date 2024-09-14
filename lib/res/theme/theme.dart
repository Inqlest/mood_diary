import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  sliderTheme: sliderThemeData(),
  elevatedButtonTheme: elevatedButtonThemeData(),
);

SliderThemeData sliderThemeData() {
  return const SliderThemeData(
    activeTrackColor: kPrimaryColor,
    inactiveTrackColor: kGreyColor5,
    inactiveTickMarkColor: kGreyColor5,
    trackHeight: 6,
    overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
    thumbColor: kPrimaryColor,
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
      style: ButtonStyle(
    textStyle: WidgetStatePropertyAll(
        buttonTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w400)),
    foregroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white;
      }
      return kGreyColor2;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.black;
      }
      return kGreyColor4;
    }),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(69),
      ),
    ),
    fixedSize: const WidgetStatePropertyAll(Size(335, 44)),
    elevation: const WidgetStatePropertyAll(0),
    animationDuration: Duration.zero,
  ));
}
