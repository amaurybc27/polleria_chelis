
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.form:  (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({ Key? key, required this.request, required this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: AlertDialog(
          title: Text('Reset settings?'),
          content: Text('This will reset your device to its default factory settings.'),
          actions: [
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () {},
              child: Text('CANCEL'),
            ),
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () {},
              child: Text('ACCEPT'),
            ),
          ],
        )
    );
  }
}

class _FormDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key? key, required this.request, required this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: AlertDialog(
          title: Text('Reset settings?'),
          content: Text('This will reset your device to its default factory settings.'),
          actions: [
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () {},
              child: Text('CANCEL'),
            ),
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () {},
              child: Text('ACCEPT'),
            ),
          ],
        )
    );
  }
}


/// The type of dialog to show
enum DialogType { basic, form }