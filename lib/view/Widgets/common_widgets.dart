import 'package:flutter/material.dart';
import 'package:noviindus/core/constants/app_constants.dart';
import 'package:noviindus/model/category_response/category.dart';
import 'package:noviindus/provider/feed_provider.dart';
import 'package:provider/provider.dart';

class CommonWidgets {
  static Widget buildCategoryChip({
    required Category category,
    required int index,
  }) {
    return Consumer<FeedProvider>(
      builder: (context, feedProvider, child) {
        final isSelected = feedProvider.selectedCategories.contains(category);
        return GestureDetector(
          onTap: () {
            feedProvider.toggleCategorySelection(category);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppConstants.red.withValues(alpha: 0.5),
                width: 1,
              ),
              color: isSelected
                  ? AppConstants.red.withValues(alpha: 0.9)
                  : Colors.black,
            ),
            child: Text(
              category.title!,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        );
      },
    );
  }
}
