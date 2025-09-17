import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frijo/core/constants/app_constants.dart';

import 'package:frijo/model/category_response/category.dart';
import 'package:frijo/view/Widgets/category_chip_widget.dart';
import 'package:frijo/view/theme/constants.dart';
import 'package:frijo/view/theme/text_styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;

  const ProfileHeaderWidget({
    super.key,
    required this.categories,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text("Hello Maria", style: t900_20),
                  Text("Welcome Back to Section", style: t500_14),
                ],
              ),
              CircleAvatar(
                radius: 32,
                backgroundColor:
                    Colors.grey.shade800, // subtle bg for empty state
                backgroundImage: const AssetImage(
                  "assets/images/user_placeholder.jpg",
                ),
              ),
            ],
          ),
          verticalSpace(30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.red.withAlpha(50),
                        borderRadius: BorderRadius.circular(24),

                        border: Border.all(color: AppConstants.red),
                      ),
                      child: Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SvgPicture.asset(
                            "assets/images/explore_icon.svg",
                            height: 20,
                          ),
                          Text("Explore", style: t500_16),
                        ],
                      ),
                    ),
                    horizontalSpace(24),
                    Container(
                      color: Colors.white.withAlpha(100),
                      // thickness: 1.2,
                      width: 0.5,
                      height: 40,
                    ),
                    horizontalSpace(24),
                    ...categories.asMap().entries.map((entry) {
                      final index = entry.key; // index of the category
                      final e = entry.value; // category object itself
                      return CategoryChipWidget(
                        title: e.title!,
                        isSelected: selectedIndex == index,
                        index: index,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
