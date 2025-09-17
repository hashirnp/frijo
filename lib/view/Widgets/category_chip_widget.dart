import 'package:flutter/material.dart';
import 'package:noviindus/injection.dart';
import 'package:noviindus/provider/feed_provider.dart';
import 'package:noviindus/view/theme/text_styles.dart';

class CategoryChipWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final int index;
  const CategoryChipWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt<FeedProvider>().setSelectedCategoryIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade900 : null,
          borderRadius: BorderRadius.circular(24),

          border: Border.all(color: Colors.white, width: 0.8),
        ),
        child: Text(title, style: t500_16),
      ),
    );
  }
}
