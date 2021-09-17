import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:polleria_chelis/app/commons/strings.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(Function getProductNumberInCart, Function navigateToSummaryView, bool showShoppingCar)
      : super(
    toolbarHeight: kToolbarHeight,
    backgroundColor: AppTheme.primaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: AppTheme.typographySecondaryColor),
    title: const Text(
      Strings.titleSearchBarMerchant,
      style: TextStyle(color: AppTheme.typographySecondaryColor),
    ),
    actions: <Widget>[
      Stack(
        children: [
          Positioned(
            top: 5,
            left: 3,
            child: ClipOval(
              child: Container(
                width: 12,
                height: 12,
                alignment: Alignment.center,
                color: AppTheme.secondaryColor,
                child: Text(
                  getProductNumberInCart().toString(),
                  style: TextStyle(
                      fontSize: 10, color: AppTheme.typographyColor),
                ),
              ),
            ),
          ),
          showShoppingCar == true ? IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              navigateToSummaryView != null
                  ? navigateToSummaryView.call()
                  : null;
            },
          ) : Text(""),
        ],
      ),
    ],
  );
}
