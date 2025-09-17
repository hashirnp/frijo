import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noviindus/view/Widgets/category_chip_widget.dart';
import 'package:noviindus/view/theme/constants.dart';
import 'package:noviindus/view/theme/text_styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

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
                        color: Colors.red.shade900.withAlpha(50),
                        borderRadius: BorderRadius.circular(24),

                        border: Border.all(color: Colors.red.shade900),
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
                    ...["Art", "Science", "History", "Technology"].map((e) {
                      return CategoryChipWidget(title: e, isSelected: false);
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
