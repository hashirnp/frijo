import 'package:flutter/material.dart';

TextStyle get t400_14 => getstyle(weight: FontWeight.w400, size: 14.0);
TextStyle get t400_16 => getstyle(weight: FontWeight.w400, size: 16.0);
TextStyle get t400_18 => getstyle(weight: FontWeight.w400, size: 18.0);
TextStyle get t400_12 => getstyle(weight: FontWeight.w400, size: 12.0);
TextStyle get t400_11 => getstyle(weight: FontWeight.w400, size: 11.0);
TextStyle get t400_13 => getstyle(weight: FontWeight.w400, size: 13.0);
TextStyle get t400_10 => getstyle(weight: FontWeight.w400, size: 10.0);
TextStyle get t400_8 => getstyle(weight: FontWeight.w400, size: 8.0);
TextStyle get t400_20 => getstyle(weight: FontWeight.w400, size: 20.0);
TextStyle get t400_22 => getstyle(weight: FontWeight.w400, size: 22.0);

TextStyle get t700_14 => getstyle(weight: FontWeight.w700, size: 14.0);
TextStyle get t700_13 => getstyle(weight: FontWeight.w700, size: 13.0);
TextStyle get t700_16 => getstyle(weight: FontWeight.w700, size: 16.0);
TextStyle get t700_18 => getstyle(weight: FontWeight.w700, size: 18.0);
TextStyle get t700_12 => getstyle(weight: FontWeight.w700, size: 12.0);
TextStyle get t700_10 => getstyle(weight: FontWeight.w700, size: 10.0);
TextStyle get t700_22 => getstyle(weight: FontWeight.w700, size: 22.0);
TextStyle get t700_30 => getstyle(weight: FontWeight.w700, size: 30.0);
TextStyle get t700_20 => getstyle(weight: FontWeight.w700, size: 20.0);
TextStyle get t700_24 => getstyle(weight: FontWeight.w700, size: 24.0);
TextStyle get t700_42 => getstyle(weight: FontWeight.w700, size: 42.0);

TextStyle get t500_13 => getstyle(weight: FontWeight.w500, size: 12.5);
TextStyle get t500_14 => getstyle(weight: FontWeight.w500, size: 14.0);
TextStyle get t500_15 => getstyle(weight: FontWeight.w500, size: 15.0);
TextStyle get t500_16 => getstyle(weight: FontWeight.w500, size: 16.0);
TextStyle get t500_18 => getstyle(weight: FontWeight.w500, size: 18.0);
TextStyle get t500_12 => getstyle(weight: FontWeight.w500, size: 12.0);
TextStyle get t500_11 => getstyle(weight: FontWeight.w500, size: 11.0);
TextStyle get t500_10 => getstyle(weight: FontWeight.w500, size: 10.0);
TextStyle get t500_20 => getstyle(weight: FontWeight.w500, size: 20.0);
TextStyle get t500_22 => getstyle(weight: FontWeight.w500, size: 22.0);
TextStyle get t500_24 => getstyle(weight: FontWeight.w500, size: 24.0);

TextStyle get t600_14 => getstyle(weight: FontWeight.w600, size: 14.0);
TextStyle get t900_20 => getstyle(weight: FontWeight.w900, size: 20.0);

TextStyle get t800_16 => getstyle(weight: FontWeight.w800, size: 16.0);

getstyle({
  Color? color,
  required FontWeight weight,
  String? fontFamily,
  required double size,
  double? height,
}) {
  return TextStyle(
    color: color ?? const Color(0xffffffff),
    fontWeight: weight,
    fontStyle: FontStyle.normal,
    fontSize: size,
    height: height,
  );
}
