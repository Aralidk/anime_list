import 'package:flutter/material.dart';
import '../constants/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColorDark: krakenBlack,
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Colors.grey,
    hintColor: Colors.grey,
    appBarTheme: AppBarTheme(
        color: krakenBlack,
        titleTextStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    fontFamily: 'Poppins',
    focusColor: krakenRed,
    fontFamilyFallback: const ['Roboto'],
    iconTheme: IconThemeData(
      color: krakenRed,
      opacity: 1,
      size: 24,
    ),
    listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: krakenRed))),
    popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: krakenRed, width: 1)),
        textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Colors.black),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black))),
    primaryIconTheme: IconThemeData(
      color: krakenDarkRed,
      opacity: 1,
      size: 24,
    ),
    textTheme: const TextTheme(
        titleMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
        titleSmall: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 2),
  );
}
