import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

ThemeData light({Color color = const Color(0xFFFFFFFF)}) => ThemeData(
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge)),
      primaryColor: color,
      // secondaryHeaderColor: const Color(0xFF1ED7AA),
      // disabledColor: const Color(0xFFBABFC4),
      // backgroundColor: const Color(0xFFFFFFFF),
      // errorColor: const Color(0xFFE84D4F),
      // brightness: Brightness.light,
      // hintColor: const Color(0xFF9F9F9F),
      // cardColor: Colors.white,
      colorScheme: const ColorScheme.light(
          primary: Colors.white, secondary: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: color,
            backgroundColor: Colors.black,
            minimumSize: const Size(
                double.infinity, Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE),
            textStyle: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
      ),
    );
