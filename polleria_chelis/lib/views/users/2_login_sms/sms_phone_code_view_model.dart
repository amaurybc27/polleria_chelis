
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/enum/status_dialog_type.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SmsPhoneCodeViewModel extends ReactiveViewModel {
  bool _sendSmsCodeButtonState = false;
  bool _keyboardState = false;

  final AuthenticationDataService _authenticationDataService =
  locator<AuthenticationDataService>();

  final KeyboardVisibilityController _keyboardVisibilityController =
  new KeyboardVisibilityController();

  final _phoneNumberFormatter = MaskTextInputFormatter(
      mask: "+## ### - ### - ####", filter: {"#": RegExp(r'[0-9]')});

  final _phoneCodeInputFormatter = MaskTextInputFormatter(
      mask: "# - # - # - # - # - #", filter: {"#": RegExp(r'[0-9]')});

  final NavigationService _navigationService = locator<NavigationService>();

  final DialogService _dialogService = locator<DialogService>();

  final SnackbarService _snackbarService = locator<SnackbarService>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SmsPhoneCodeViewModel() {
    _keyboardVisibilityController.onChange.listen((bool visible) {
      _keyboardState = visible;
    });
  }

  get phoneCodeInputFormatter => _phoneCodeInputFormatter;

  get sendSmsCodeButtonState => _sendSmsCodeButtonState;

  void setSendSmsCodeButtonState() {
    _sendSmsCodeButtonState =
        _phoneCodeInputFormatter.getUnmaskedText().length == 6;
    notifyListeners();
  }

  get keyboardState => _keyboardState;

  get smsResendCounter => _authenticationDataService.smsResendCounter;

  get formattedPhoneNumber =>
      _phoneNumberFormatter.maskText(_authenticationDataService.phoneNumber);

  Future<void> resendSmscode() async {
    setBusy(true);

    final String phoneNumber = _authenticationDataService.phoneNumber;
    print('contador: ${_authenticationDataService.smsResendCounter}');
    print('telefono anterior: ${_authenticationDataService.phoneNumber}');

    /*final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int resendToken]) {
      print('PhoneCodeSent');
      print('verificationId: ' + verificationId);
      print('resendToken: ' + resendToken.toString());

      _authenticationDataService.setValidationSmsData(
          phoneNumber, verificationId, resendToken);

      print('codigo enviado');

      _snackbarService.showSnackbar(String: 'Código enviado'
          /*message: 'Código enviado',
        duration: Duration(seconds: 2),*/
          );

      setBusy(false);
    };*/

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

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> smsCodeValidation() async {
    setBusy(true);

    String smsCode = _phoneCodeInputFormatter.getUnmaskedText();

    print('verificationId: ${_authenticationDataService.verificationId}');
    print('smsCode: $smsCode');
    print('phoneNumber: ${_authenticationDataService.phoneNumber}');

    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _authenticationDataService.verificationId,
        smsCode: smsCode);

    print('AuthCredential: ' + _authCredential.toString());

    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(_authCredential);

      if (userCredential.user != null) {
        print('Validacion de credencial exitosa por SMS');
        // Valiar que no se pueda regresar a la pantalla anterior
        navigateToProductsView();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ProductDetail(),
        //     ),
        //     (Route<dynamic> route) => false);
      } else {
        print('Error al validar codigo SMS');
        await _dialogService.showCustomDialog(
            description: Strings.PhoneAuthErrorMessage,
            customData: StatusDialogType.error);
        setBusy(false);
      }
    } on FirebaseAuthException catch (e) {
      print('Error al validar codigo SMS:  $e');
      String errorMessage;
      print(e.code);
      switch (e.code) {
        case 'ERROR_INVALID_VERIFICATION_CODE':
          errorMessage = 'codigo invalido';
          break;
        case 'ERROR_SESSION_EXPIRED':
          errorMessage = 'codigo expirado';
          break;
        default:
          errorMessage = Strings.PhoneAuthErrorMessage;
          break;
      }

      await _dialogService.showCustomDialog(
          description: errorMessage, customData: StatusDialogType.error);
      setBusy(false);
    }
  }

  Future navigateToSmsPhoneNumberView() async {
    await _navigationService.navigateTo(Routes.smsPhoneNumberView);
  }

  Future navigateToProductsView() async {
    await _navigationService.clearStackAndShow(Routes.productsView);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authenticationDataService];
}
