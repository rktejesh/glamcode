import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';

ThemeData light({Color color = const Color(0xFFFFFFFF)}) => ThemeData(
      fontFamily: 'Roboto',
      backgroundColor: const Color(0xFFFFF1F1),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.black),
          color: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold)),
      primaryColor: color,
      // secondaryHeaderColor: const Color(0xFF1ED7AA),
      // disabledColor: const Color(0xFFBABFC4),
      // backgroundColor: const Color(0xFFFFFFFF),
      // errorColor: const Color(0xFFE84D4F),
      // brightness: Brightness.light,
      // hintColor: const Color(0xFF9F9F9F),
      // cardColor: Colors.white,
      colorScheme: const ColorScheme.light(
          primary: Colors.black, secondary: Colors.white),
      scaffoldBackgroundColor: const Color(0xFFFFF1F1),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            foregroundColor: color,
            backgroundColor: const Color(0xFFA854FC),
            minimumSize: const Size(
                double.infinity, Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT),
            textStyle: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
      ),
    );
