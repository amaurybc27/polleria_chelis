import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';

class AppTheme {

  AppTheme._();

  static const Color typographyColor = Color(0xFF181441);
  static const Color typographySecondaryColor = Color(0xFFFFFFFF);

  static const Color primaryColor = Color(0xFF607D8B);
  static const Color primaryVariantColor = Color(0xFF455A64);
  static const Color primaryOpacitiColor = Color(0xFFECEFF1);
  static const Color secondaryColor = Color(0xFFFFE082);
  static const Color secondaryVariantColor = Color(0xFFFFA000);

  static const Color backgroundColor = Colors.white;
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);
  static const Color facebookColor = Color(0xFF4267B2);

  static const Color priceColor = Color(0xFFF28A2E);
  static const Color opacitiColor = Color(0xFFBFBFBF);
  static const Color errorColor = Color(0xFFCC0000);
  static const Color successColor = Color(0xFF007E33);
  static const Color warningColor = Color(0xFFFF8800);

  static const Color disabledButtonColor = Color(0xFFcccccc);
  static const Color disabledButtonTextColor = Color(0xFF9a9999);


  static const double horizontalMargin = 3.9;


  static const TextTheme darkText = TextTheme(
    headline1 : TextStyle(debugLabel: 'blackMountainView headline1', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5), //96
    headline2 : TextStyle(debugLabel: 'blackMountainView headline2', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5), //60
    headline3 : TextStyle(debugLabel: 'blackMountainView headline3', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 48, fontWeight: FontWeight.w400), //48
    headline4 : TextStyle(debugLabel: 'blackMountainView headline4', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25), //34
    headline5 : TextStyle(debugLabel: 'blackMountainView headline5', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 24,fontWeight: FontWeight.w400), //24
    headline6 : TextStyle(debugLabel: 'blackMountainView headline6', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.15), //20
    subtitle1 : TextStyle(debugLabel: 'blackMountainView subtitle1', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 16,fontWeight: FontWeight.w500,letterSpacing: 0.15), //16
    subtitle2 : TextStyle(debugLabel: 'blackMountainView subtitle2', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.1), //14
    bodyText1 : TextStyle(debugLabel: 'blackMountainView bodyText1', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 0.5), //16
    bodyText2 : TextStyle(debugLabel: 'blackMountainView bodyText2', fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.25), //14
    caption   : TextStyle(debugLabel: 'blackMountainView caption',   fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 12,fontWeight: FontWeight.w400,letterSpacing: 0.4), //12
    button    : TextStyle(debugLabel: 'blackMountainView button',    fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 1.25), //14
    overline  : TextStyle(debugLabel: 'blackMountainView overline',  fontFamily: 'Roboto', inherit: true, color: typographyColor, decoration: TextDecoration.none, fontSize: 10,fontWeight: FontWeight.w400,letterSpacing: 1.5), //10
  );

  static const TextTheme lightText = TextTheme(
    headline1 : TextStyle(debugLabel: 'blackMountainView headline1', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5), //96
    headline2 : TextStyle(debugLabel: 'blackMountainView headline2', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5), //60
    headline3 : TextStyle(debugLabel: 'blackMountainView headline3', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 48, fontWeight: FontWeight.w400), //48
    headline4 : TextStyle(debugLabel: 'blackMountainView headline4', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25), //34
    headline5 : TextStyle(debugLabel: 'blackMountainView headline5', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 24,fontWeight: FontWeight.w400), //24
    headline6 : TextStyle(debugLabel: 'blackMountainView headline6', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.15), //20
    subtitle1 : TextStyle(debugLabel: 'blackMountainView subtitle1', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 0.15), //16
    subtitle2 : TextStyle(debugLabel: 'blackMountainView subtitle2', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 0.1), //14
    bodyText1 : TextStyle(debugLabel: 'blackMountainView bodyText1', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 0.5), //16
    bodyText2 : TextStyle(debugLabel: 'blackMountainView bodyText2', fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.25), //14
    caption   : TextStyle(debugLabel: 'blackMountainView caption',   fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 12,fontWeight: FontWeight.w400,letterSpacing: 0.4), //12
    button    : TextStyle(debugLabel: 'blackMountainView button',    fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 1.25), //14
    overline  : TextStyle(debugLabel: 'blackMountainView overline',  fontFamily: 'Roboto', inherit: true, color: typographySecondaryColor, decoration: TextDecoration.none, fontSize: 10,fontWeight: FontWeight.w400,letterSpacing: 1.5), //10
  );

  static const TextTheme errorText = TextTheme(
    headline1 : TextStyle(debugLabel: 'blackMountainView headline1', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5), //96
    headline2 : TextStyle(debugLabel: 'blackMountainView headline2', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5), //60
    headline3 : TextStyle(debugLabel: 'blackMountainView headline3', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 48, fontWeight: FontWeight.w400), //48
    headline4 : TextStyle(debugLabel: 'blackMountainView headline4', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25), //34
    headline5 : TextStyle(debugLabel: 'blackMountainView headline5', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 24,fontWeight: FontWeight.w400), //24
    headline6 : TextStyle(debugLabel: 'blackMountainView headline6', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 0.15), //20
    subtitle1 : TextStyle(debugLabel: 'blackMountainView subtitle1', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 0.15), //16
    subtitle2 : TextStyle(debugLabel: 'blackMountainView subtitle2', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 0.1), //14
    bodyText1 : TextStyle(debugLabel: 'blackMountainView bodyText1', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 0.5), //16
    bodyText2 : TextStyle(debugLabel: 'blackMountainView bodyText2', fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w400,letterSpacing: 0.25), //14
    caption   : TextStyle(debugLabel: 'blackMountainView caption',   fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 12,fontWeight: FontWeight.w400,letterSpacing: 0.4), //12
    button    : TextStyle(debugLabel: 'blackMountainView button',    fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 1.25), //14
    overline  : TextStyle(debugLabel: 'blackMountainView overline',  fontFamily: 'Roboto', inherit: true, color: error, decoration: TextDecoration.none, fontSize: 10,fontWeight: FontWeight.w400,letterSpacing: 1.5), //10
  );

}