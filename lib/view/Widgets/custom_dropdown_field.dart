import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frijo/core/constants/app_constants.dart';
import 'package:frijo/view/theme/text_styles.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final double? marginBottom;
  final String Function(T)? itemAsString;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.marginBottom,
    this.itemAsString, // 👈 add this
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: t400_16.copyWith(color: Colors.black)),
          const SizedBox(height: 8),
          DropdownButtonFormField<T>(
            initialValue: value,
            onChanged: onChanged,
            dropdownColor: Colors.white,
            icon: const Icon(
              CupertinoIcons.chevron_down,
              color: Colors.green,
              size: 20,
              weight: 900,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppConstants.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade500),
              ),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      itemAsString != null
                          ? itemAsString!(item)
                          : item.toString(), // 👈 use mapper
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
