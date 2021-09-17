
import 'package:polleria_chelis/app/commons/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

import 'locator.dart';



void setupSnackbarUi() {
  final snackbarService = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  snackbarService.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: AppTheme.primaryColor,
    snackPosition: SnackPosition.BOTTOM,
    messageColor: AppTheme.typographySecondaryColor,
    titleColor: AppTheme.typographySecondaryColor,
  ));

}