import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const SizedBox(height: 32),
        Text(
          'Показатели за последние 30 дней',
          style: titleTextStyle,
        ),
        const SizedBox(height: 16),
        _buildRecentStatistics(),
      ],
    );
  }

  Widget _buildRecentStatistics() {
    return Column(
      children: [
        _buildStatItem('Средний уровень стресса за неделю', '3.2'),
        _buildStatItem('Наиболее частая эмоция', 'Радость'),
        _buildStatItem('Количество записей в этом месяце', '8'),
      ],
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: kGreyColor4,
            spreadRadius: 2,
            blurRadius: 10.8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: titleTextStyle),
          Text(value, style: titleTextStyle.copyWith(color: kPrimaryColor)),
        ],
      ),
    );
  }
}
