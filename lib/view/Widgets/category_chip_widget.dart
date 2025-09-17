import 'package:flutter/material.dart';
import 'package:noviindus/view/theme/text_styles.dart';

class CategoryChipWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CategoryChipWidget({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade900 : null,
        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: Colors.white, width: 0.8),
      ),
      child: Text(title, style: t500_16),
    );
  }
}
