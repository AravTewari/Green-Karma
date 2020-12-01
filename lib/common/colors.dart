import 'package:flutter/material.dart';

class MyTheme {
  // Set the colors here
  static MyColors colors = MyColors.vibrant;

  static ThemeData get themeData {
    return ThemeData.light().copyWith(
      primaryColor: colors.primary,
      accentColor: colors.accent,
      highlightColor: colors.gradient2,
      backgroundColor: colors.backgroundMain,
      scaffoldBackgroundColor: colors.backgroundMain,
      cardColor: colors.backgroundShaded,
      dialogBackgroundColor: colors.backgroundMain,

      //changes the calendar picker color
      colorScheme: ColorScheme.light(
        primary: colors.primary, //Color of the top area
        onPrimary: colors.backgroundMain, //top area text color
        surface: colors.backgroundMain, //time picker background color, default is white so leaving it
        onSurface: colors.fontMain, //calendar date color
      ),
      buttonTheme: ButtonThemeData(
        disabledColor: Colors.grey,
        buttonColor: colors.accent, // Fill color of your raised buttons

        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: colors.accent, // text color for FlatButtons, date picker
          onPrimary: Colors.black, //Should be the text color of above
          secondary: colors.backgroundMain, // text color for RaisedButtons (contrast)
          onSecondary: Colors.black87, //Should be the contrast of above
          background: colors.primary, //Don't know where its used
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.redAccent,
          onError: Colors.white,
          primaryVariant: Colors.black,
          secondaryVariant: Colors.black,
        ),
        textTheme: ButtonTextTheme.accent, // Makes everything happen
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colors.contrast, // This is needed
          foregroundColor: colors.backgroundMain, // This is needed
          focusColor: colors.gradient2,
          hoverColor: Colors.white),
    );
  }
}

class MyColors {
  Color primary;
  Color accent;
  Color gradient1;
  Color gradient2;
  Color contrast;
  Color backgroundMain;
  Color backgroundShaded;
  Color fontMain;
  Color fontShaded;
  List<Color> gradientSet1;
  List<Color> gradientSet2;
  List<Color> gradientSet3;

  MyColors({
    @required this.primary,
    @required this.accent,
    @required this.gradient1,
    @required this.gradient2,
    @required this.contrast,
    @required this.backgroundMain,
    @required this.backgroundShaded,
    @required this.fontMain,
    @required this.fontShaded,
  }) {
    gradientSet1 = [this.gradient1, this.gradient2];
    gradientSet2 = [this.primary, this.contrast];
    gradientSet3 = [this.gradient1, this.primary];
  }

  static MyColors vibrant = MyColors(
    primary: const Color(0xFF2633C5),
    accent: const Color(0xFF00B6F0),
    gradient1: const Color(0xFF006838),
    gradient2: const Color(0xFF8BC53F),
    contrast: const Color(0xFFAB1187),
    backgroundMain: Colors.white,
    backgroundShaded: Colors.grey[300],
    fontMain: Colors.black,
    fontShaded: Colors.grey[800],
  );
}
