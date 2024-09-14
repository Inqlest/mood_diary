import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:diary_test_app/screens/calendar_screen.dart';
import 'package:diary_test_app/screens/diary_screen.dart';
import 'package:diary_test_app/screens/statistics_screen.dart';
import 'package:diary_test_app/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDiarySelected = true;

  void _onToggleChanged(bool value) {
    setState(() {
      isDiarySelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM HH:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kBackgroundColor,
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        actions: [
          GestureDetector(
            child:
                const Icon(Icons.calendar_month, color: kGreyColor2, size: 24),
            onTap: () => _goToDetailPage(),
          )
        ],
        title: Text(
          formattedDate,
          style: titleTextStyle.copyWith(
              fontSize: 18, color: kGreyColor2, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomToggleSwitch(
                isDiarySelected: isDiarySelected,
                onToggleChanged: _onToggleChanged,
              ),
              isDiarySelected ? const DiaryScreen() : const StatisticsScreen()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToDetailPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CalendarScreen(),
      ),
    );
  }
}
