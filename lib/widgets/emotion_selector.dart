import 'package:diary_test_app/res/constants/color_constants.dart';
import 'package:diary_test_app/res/constants/font_constants.dart';
import 'package:flutter/material.dart';

final Map<String, List<String>> subEmotions = {
  'Радость': ['Возбуждение', 'Восторг', 'Игривость'],
  'Страх': ['Тревога', 'Неуверенность', 'Паника'],
  'Бешенство': ['Злость', 'Негодование', 'Гнев'],
  'Грусть': ['Уныние', 'Огорчение', 'Печаль'],
  'Спокойствие': ['Расслабление', 'Миролюбие', 'Гармония'],
  'Сила': ['Энергия', 'Дерзость', 'Уверенность']
};

class EmotionSelector extends StatefulWidget {
  final void Function(List<String> emotions, List<String> subEmotions)
      onEmotionSelected;
  const EmotionSelector({super.key, required this.onEmotionSelected});

  @override
  State<EmotionSelector> createState() => _EmotionSelectorState();
}

class _EmotionSelectorState extends State<EmotionSelector> {
  final List<String> _selectedEmotions = [];
  final List<String> _selectedSubEmotions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _emotionCard('assets/images/happiness.png', 'Радость'),
              _emotionCard('assets/images/fear.png', 'Страх'),
              _emotionCard('assets/images/rage.png', 'Бешенство'),
              _emotionCard('assets/images/sadness.png', 'Грусть'),
              _emotionCard('assets/images/calmness.png', 'Спокойствие'),
              _emotionCard('assets/images/strength.png', 'Сила'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (_selectedEmotions.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _buildSubEmotionChips(),
          ),
      ],
    );
  }

  Widget _emotionCard(String imagePath, String emotionName) {
    final isSelected = _selectedEmotions.contains(emotionName);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedEmotions.remove(emotionName);
            _removeSubEmotions(emotionName);
          } else {
            _selectedEmotions.add(emotionName);
          }
          widget.onEmotionSelected(_selectedEmotions, _selectedSubEmotions);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: 83,
          height: 118,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(76),
            boxShadow: const [
              BoxShadow(
                color: kGreyColor4,
                spreadRadius: 2,
                blurRadius: 10.8,
                offset: Offset(2, 4),
              ),
            ],
            border: isSelected
                ? Border.all(color: kPrimaryColor, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 53, height: 50),
              Text(emotionName,
                  style:
                      subTextStyle.copyWith(color: kBlackColor, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSubEmotionChips() {
    List<Widget> subEmotionChips = [];
    for (String emotion in _selectedEmotions) {
      List<String>? subEmotionsForEmotion = subEmotions[emotion];
      if (subEmotionsForEmotion != null) {
        for (String subEmotion in subEmotionsForEmotion) {
          subEmotionChips.add(_subEmotionChip(subEmotion));
        }
      }
    }
    return subEmotionChips;
  }

  Widget _subEmotionChip(String subEmotion) {
    final isSelected = _selectedSubEmotions.contains(subEmotion);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSubEmotions.remove(subEmotion);
          } else {
            _selectedSubEmotions.add(subEmotion);
          }
          widget.onEmotionSelected(_selectedEmotions, _selectedSubEmotions);
        });
      },
      child: Chip(
        label: Text(subEmotion),
        backgroundColor: isSelected ? kPrimaryColor : Colors.white,
        labelStyle: subTextStyle.copyWith(
          color: isSelected ? Colors.white : kBlackColor,
          fontSize: 11,
        ),
        side: BorderSide.none,
        shadowColor: kGreyColor2,
        elevation: 0.3,
      ),
    );
  }

  void _removeSubEmotions(String emotionName) {
    List<String>? subEmotionList = subEmotions[emotionName];
    if (subEmotionList != null) {
      _selectedSubEmotions
          .removeWhere((subEmotion) => subEmotionList.contains(subEmotion));
    }
  }
}
