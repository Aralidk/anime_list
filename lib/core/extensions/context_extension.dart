import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.03;
  double get highValue => height * 0.1;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension TextExtension on BuildContext {
  TextTheme get textTheme => theme.textTheme;
  TextStyle get textTitleLarge => textTheme.titleLarge!;
  TextStyle get textTitleMedium => textTheme.titleMedium!;
  TextStyle get textTitleSmall => textTheme.titleSmall!;
}

extension BorderExtension on BuildContext {
  RoundedRectangleBorder get circleBorder =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0));
  RoundedRectangleBorder get roundedRectangle =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: krakenRed));
  BorderRadius get borderRadiusCirc => BorderRadius.circular(18.0);
  BorderRadius get borderRadiusSemiCirc => BorderRadius.circular(18.0);
  Border get boxBorder => Border.all(color: krakenRed);
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);
  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DividerExtension on BuildContext {
  Divider get thinDivider => const Divider(
        height: 15,
        thickness: 1,
        color: Color(0xFFE0E3E7),
      );
  Divider get thinDarkDivider =>  Divider(
    height: 15,
    thickness: 1,
    color: krakenRed,
  );
}

extension SizedBoxExtension on BuildContext {
  SizedBox get mediumHeightSizedBox => const SizedBox(height: 15);
  SizedBox get lowHeightSizedBox => const SizedBox(height: 8);
  SizedBox get highHeightSizedBox => const SizedBox(height: 30);
  SizedBox get mediumWidthSizedBox => const SizedBox(width: 15);
  SizedBox get lowWidthSizedBox => const SizedBox(width: 8);
  SizedBox get highWidthSizedBox => const SizedBox(width: 30);
  SizedBox get extraLowSizedBox => const SizedBox(height: 4.0);
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);
  Duration get normalDuration => const Duration(seconds: 1);
}
