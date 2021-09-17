import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double _screenWidth = 0.0;
  static double _screenHeight = 0.0;
  static double _horizontalBlocks = 0.0;
  static double _verticalBlocks = 0.0;

  //static double textMultiplier;
  //static double imageSizeMultiplier;
  static double heightMultiplier = 0.0;
  static double widthMultipier = 0.0;

  void init(BoxConstraints constraints) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    _horizontalBlocks = _screenWidth / 100;
    _verticalBlocks = _screenHeight / 100;

    //textMultiplier = _verticalBlocks;
    //imageSizeMultiplier = _horizontalBlockSize;
    heightMultiplier = _verticalBlocks;
    widthMultipier = _horizontalBlocks;

    print('screen width:  ' + '$_screenWidth');
    print('screen height:  ' + '$_screenHeight');
    print('horizontal blocks:  ' + '$_horizontalBlocks');
    print('vertical blocks:  ' + '$_verticalBlocks');
    print('height multiplier:  ' + '$heightMultiplier');
    print('width multipier:  ' + '$widthMultipier');
  }
}
