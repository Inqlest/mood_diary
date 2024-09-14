import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _showYearView = false;
  double _previousScale = 1.0;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = _focusedDay;
              });
            },
            child: Text(
              'Сегодня',
              style: titleTextStyle.copyWith(
                  color: kGreyColor2,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onScaleUpdate: (details) {
          if (details.scale > _previousScale && !_showYearView) {
            setState(() {
              _showYearView = true;
            });
          } else if (details.scale < _previousScale && _showYearView) {
            setState(() {
              _showYearView = false;
            });
          }
          _previousScale = details.scale;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _showYearView
                  ? Text(
                      _focusedDay.year.toString(),
                      style: titleTextStyle,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          7,
                          (index) {
                            return Text("${days[index]} ");
                          },
                        ),
                      ),
                    ),
              Expanded(
                child: _showYearView
                    ? _buildYearView()
                    : _buildScrollableMonthView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableMonthView() {
    final int currentMonth = _focusedDay.month;
    final List<int> months =
        List.generate(12, (index) => (currentMonth + index - 1) % 12 + 1);

    return SingleChildScrollView(
      child: Column(
        children: months
            .map((month) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildMonthCalendar(month, 24, 18, 52),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMonthCalendar(
      int month, double montSize, double daySize, double rowHeight) {
    final DateTime firstDayOfMonth = DateTime(_focusedDay.year, month, 1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TableCalendar(
        rowHeight: rowHeight,
        availableGestures: AvailableGestures.none,
        daysOfWeekVisible: false,
        pageJumpingEnabled: false,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: firstDayOfMonth,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          titleTextStyle: titleTextStyle.copyWith(fontSize: montSize),
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonVisible: false,
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(1),
          todayTextStyle: dayCalendarTextStyle.copyWith(fontSize: daySize),
          selectedTextStyle: dayCalendarTextStyle.copyWith(fontSize: daySize),
          todayDecoration: const BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
        ),
        onPageChanged: null,
      ),
    );
  }

  Widget _buildYearView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = DateTime(_focusedDay.year, index + 1);
        return GestureDetector(
          onTap: () {
            setState(() {
              _showYearView = false;
              _focusedDay = month;
            });
          },
          child: _buildMonthCalendar(index, 14, 8, 20),
        );
      },
    );
  }
}
