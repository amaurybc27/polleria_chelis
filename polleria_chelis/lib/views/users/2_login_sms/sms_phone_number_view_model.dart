
import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/enum/status_dialog_type.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/commons/strings.dart';

class SmsPhoneNumberViewModel extends BaseViewModel {
  bool _sendPhoneNumberButtonState = false;
  String _phoneNumberCountryCode = "";
  bool _keyboardState = false;

  final AuthenticationDataService _authenticationDataService =
  locator<AuthenticationDataService>();

  final KeyboardVisibilityController _keyboardVisibilityController = new KeyboardVisibilityController();

  final _phoneNumberInputFormatter = MaskTextInputFormatter(
      mask: "### - ### - ####", filter: {"#": RegExp(r'[0-9]')});

  final NavigationService _navigationService = locator<NavigationService>();

  final DialogService _dialogService = locator<DialogService>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SmsPhoneNumberViewModel() {
    _keyboardVisibilityController.onChange.listen((bool visible) {
      _keyboardState = visible;
    });
  }

  get sendPhoneNumberButtonState => _sendPhoneNumberButtonState;

  void setSendPhoneNumberButtonState() {
    _sendPhoneNumberButtonState =
        _phoneNumberInputFormatter.getUnmaskedText().length == 10;
    notifyListeners();
  }

  void setPhoneNumberCountryCode(CountryCode countryCode) {
    _phoneNumberCountryCode = countryCode.dialCode!;
  }

  get keyboardState => _keyboardState;
  get phoneNumberInputFormatter => _phoneNumberInputFormatter;

  Future<void> sendSmscode(bool isPhoneNumberView) async {
    setBusy(true);

    final String phoneNumber =
        '$_phoneNumberCountryCode ${_phoneNumberInputFormatter.getUnmaskedText()}';
    print('contador: ${_authenticationDataService.smsResendCounter}');
    print('telefono anterior: ${_authenticationDataService.phoneNumber}');
    print('Codigo pais: $_phoneNumberCountryCode');
    print('telefono ingresado: $phoneNumber');

    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int? resendToken]) {
      print('PhoneCodeSent');
      print('verificationId: ' + verificationId);
      print('resendToken: ' + resendToken.toString());

      _authenticationDataService.setValidationSmsData(
          phoneNumber, verificationId, resendToken!);

      navigateToSmsCodeView();
    };

    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      print('PhoneVerificationCompleted');
      UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      if (userCredential != null) {
        print("Validacion de credencial exitosa (playstore)");
        navigateToProductsView();
      } else {
        print("Error al validar credencial (playstore)");
        await _dialogService.showCustomDialog(
            description: Strings.PhoneAuthErrorMessage,
            customData: StatusDialogType.error);
      }
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) async {
      print('PhoneVerificationFailed');
      print('PhoneVerificationFailed message: ' + firebaseAuthException.message.toString());

      String errorMessage;
      if (firebaseAuthException.message!.contains('not authorized'))
        errorMessage =
        'Something has gone wrong, please try later (not authorized)';
      else if (firebaseAuthException.message!.contains('Network'))
        errorMessage =
        'Please check your internet connection and try again (network)';
      else
        errorMessage = Strings.PhoneAuthErrorMessage;

      await _dialogService.showCustomDialog(
          description: errorMessage, customData: StatusDialogType.error);
      setBusy(false);
    };

    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      print('AutoRetrievalTimeout reached, verificationId: ' + verificationId);
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  Future navigateToSmsCodeView() async {
    await _navigationService.navigateTo(Routes.smsPhoneCodeView);
  }

  Future navigateToOnBoardingView() async {
    await _navigationService.navigateTo(Routes.onboardingView);
  }

  Future navigateToProductsView() async {
    await _navigationService.clearStackAndShow(Routes.productDetailView);
  }
}
