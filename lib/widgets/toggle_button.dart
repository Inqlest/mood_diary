import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool isDiarySelected;
  final ValueChanged<bool> onToggleChanged;
  const CustomToggleSwitch(
      {super.key,
      required this.isDiarySelected,
      required this.onToggleChanged});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 288,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(47),
          color: kGreyColor4,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.onToggleChanged(true);
                });
              },
              child: Container(
                width: 172,
                decoration: BoxDecoration(
                  color: widget.isDiarySelected
                      ? kPrimaryColor
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(47),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        color:
                            widget.isDiarySelected ? Colors.white : kGreyColor4,
                        size: 12,
                      ),
                      Text(
                        'Дневник настроения',
                        style: buttonTextStyle.copyWith(
                          color: widget.isDiarySelected
                              ? Colors.white
                              : kGreyColor4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.onToggleChanged(false);
                });
              },
              child: Container(
                width: 116,
                decoration: BoxDecoration(
                  color: !widget.isDiarySelected
                      ? kPrimaryColor
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(47),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bar_chart_outlined,
                        color: !widget.isDiarySelected
                            ? Colors.white
                            : kGreyColor4,
                        size: 12,
                      ),
                      Text(
                        'Статистика',
                        style: buttonTextStyle.copyWith(
                          color: !widget.isDiarySelected
                              ? Colors.white
                              : kGreyColor4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
