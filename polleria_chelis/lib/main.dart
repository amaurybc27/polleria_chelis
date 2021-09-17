import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/size_config.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/setup/app_setup.router.dart';
import 'app/setup/locator.dart';
import 'app/setup/setup_dialog_ui.dart';
import 'app/setup/setup_snackbar_ui.dart';
import 'models/configuration_parameters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setUpLocator();
  setupDialogUi();
  setupSnackbarUi();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp() {
    ConfigurationParameters.init();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SizeConfig().init(constraints);
        return MaterialApp(
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
        );
      },
    );
  }
}
