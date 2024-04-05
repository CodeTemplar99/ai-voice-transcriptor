import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double defaultSize = 0.0;
  static Orientation orientation = Orientation.portrait;
  static bool isTablet = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    bool isTablet = _mediaQueryData.size.shortestSide >= 600;
    SizeConfig.isTablet = isTablet;
  }
}

// get height per mobile screen size
double getScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 800.0) * screenHeight;
}

// get width per mobile screen size
double getScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 360.0) * screenWidth;
}

// add free space vertically on mobile
class VerticalSpacingMobile extends StatelessWidget {
  const VerticalSpacingMobile({super.key, required this.heightValue});
  final double heightValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightValue,
    );
  }
}

//mobile
//h1
double h1FontSize = getScreenHeight(30);

//h2
double h2FontSize = getScreenHeight(20);

//h3
double h3FontSize = getScreenHeight(18);

//padding
double padding = getScreenHeight(20);

//body text
double textFontSize = getScreenHeight(15);

//small padding vertical
double smallVerticalPadding = getScreenHeight(15);

//small padding horizontal
double smallHorizontalPadding = getScreenHeight(15);

//horizontal padding
double horizontalPadding = getScreenHeight(20);

// vertical padding big screen
double verticalPadding = getScreenHeight(20);

//button heights
double buttonHeight = getScreenHeight(53);

//button border radius
double buttonBorderRadius = getScreenHeight(6);

//button border radius
double cardBorderRadius = getScreenHeight(6);

//text field border radius
double textFieldBorderRadius = getScreenHeight(10);
