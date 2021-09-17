import 'dart:async';

import 'package:observable_ish/value/value.dart';
import 'package:polleria_chelis/models/users.dart';
import 'package:stacked/stacked.dart';

class AuthenticationDataService with ReactiveServiceMixin {
  String _verificationId = "";
  int _resendToken = 0;
  String _phoneNumber = "";
  bool _isAdmin = false;
// Rappi pone 600 segundos
  static const int _smsResendTimeout = 5;
  Timer? _smsTimer;
  RxValue<int> _smsResendCounter = RxValue<int>(0);

  AuthenticationDataService() {
    listenToReactiveValues([_smsResendCounter]);
  }

  bool get isAdmin => this._isAdmin;
  String get phoneNumber => _phoneNumber;
  String get verificationId => _verificationId;
  int get resendToken => _resendToken;
  int get smsResendCounter => _smsResendCounter.value;

  void setValidationSmsData(
      String phoneNumber, String verificationId, int resendToken) {
    print("setValidationSmsData");
    _phoneNumber = phoneNumber;
    _verificationId = verificationId;
    _resendToken = resendToken;
    _resetSmsTimer();
    this.isAdminUser();
  }

  void _resetSmsTimer() {
    _smsResendCounter.value = _smsResendTimeout;
    if (_smsTimer != null) {
      _smsTimer!.cancel();
    }

    // timer creation in seconds
    _smsTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_smsResendCounter.value > 0) {
        _smsResendCounter.value--;
      }
    });
  }


  Future<void> isAdminUser() async {
    List<Users> usersList = [];
    bool existUser = await Users.isAdminUser(phoneNumber);

    if (existUser) {
      print("Usuario admin");
      this._isAdmin = true;
    } else {
      print("Usuario no admin");
    }
  }
}
