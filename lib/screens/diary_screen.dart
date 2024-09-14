import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:diary_test_app/widgets/emotion_selector.dart';
import 'package:diary_test_app/widgets/stress_level_slider.dart';
import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  List<String> _selectedEmotions = [];
  List<String> _selectedSubEmotions = [];
  bool _isEmotionSelected = false;

  void _onEmotionSelected(List<String> emotions, List<String> subEmotions) {
    setState(() {
      _selectedEmotions = emotions;
      _selectedSubEmotions = subEmotions;
      _isEmotionSelected =
          _selectedEmotions.isNotEmpty && _selectedSubEmotions.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text('Что чувствуешь?', style: titleTextStyle),
        const SizedBox(height: 20),
        EmotionSelector(onEmotionSelected: _onEmotionSelected),
        const SizedBox(height: 36),
        Text('Уровень стресса', style: titleTextStyle),
        const SizedBox(height: 20),
        StressLevelSlider(
            leftLabel: 'Низкий',
            rightLabel: 'Высокий',
            isActive: _isEmotionSelected),
        const SizedBox(height: 36),
        Text('Самооценка', style: titleTextStyle),
        const SizedBox(height: 20),
        StressLevelSlider(
          leftLabel: 'Неуверенность',
          rightLabel: 'Уверенность',
          isActive: _isEmotionSelected,
        ),
        const SizedBox(height: 36),
        Text('Заметки', style: titleTextStyle),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: kGreyColor4,
                spreadRadius: 2,
                blurRadius: 10.8,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: TextField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Введите заметку',
              hintStyle:
                  subTextStyle.copyWith(color: kGreyColor2, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 35),
        Center(
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: _isEmotionSelected
                    ? const WidgetStatePropertyAll(kPrimaryColor)
                    : const WidgetStatePropertyAll(kGreyColor4),
                foregroundColor: _isEmotionSelected
                    ? const WidgetStatePropertyAll(Colors.white)
                    : const WidgetStatePropertyAll(kGreyColor2),
              ),
              onPressed: _isEmotionSelected ? _showSuccessDialog : null,
              child: const Text('Сохранить')),
        ),
        const SizedBox(height: 46),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Успех'),
          content: const Text('Ваши данные успешно сохранены!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
