
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/configuration_parameters.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/enum/payment_methods.dart';
import 'package:polleria_chelis/models/order_item.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/models/shipping.dart';
import 'package:polleria_chelis/models/users.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_summaryDataService];

  List<String> _paymentMethodsList = [PaymentMethods.CASH.method, PaymentMethods.TPV.method];
  get getPaymentMethodsList => this._paymentMethodsList;

  PaymentMethods? _character = PaymentMethods.CASH;
  get getCharacter => this._character;
  void setCharacter(PaymentMethods newValue){
    this._character = newValue;
    notifyListeners();
  }


  bool isEnableButton() {
    bool enable = false;

    if(this._character == PaymentMethods.TPV){
      enable = true;
    } else if (this._character == PaymentMethods.CASH ){
      enable = true;
    }

    return enable;
  }

  String _denominationSelected = "50";
  get getDenominationSelected => this._denominationSelected;
  void setDenominationSelected(String newValue){
    this._denominationSelected = newValue;
    notifyListeners();
  }

  List<String> getDenominations(){
    List<String> denominations = new List<String>.from(ConfigurationParameters.getParameter(ConfigurationParameters.notesDenominations));
    denominations.forEach((element) {
    });
    return denominations;
  }

  //------------------------- SUMMARY SERVICE -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();
  get getSummaryDataService => _summaryDataService;

  int getProductNumberInCart() {
    return this._summaryDataService.counter;
  }

  //------------------------- NAVIGATION -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSummaryView() async {
    null;
  }

  Future navigateToProductDetail() async{
    if(this._character == PaymentMethods.TPV){
      await this.saveOrder(PaymentMethods.TPV, 0);
    }else {
      await this.saveOrder(PaymentMethods.CASH, double.parse(this._denominationSelected));
    }

    this.showFinishSnackbar();

    Future.delayed(Duration(seconds: 4), () {
      this._summaryDataService.clearData();
      _navigationService.navigateTo(Routes.productsView);
    });
  }

  //------------------------- DIALOG -------------------------
  final DialogService _dialogService = locator<DialogService>();
  Future showConfirmDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      title: Strings.confirmDialogTitle,
      description: Strings.confirmDialogDescription,
      buttonTitle: Strings.confirmDialogAcept,
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: Strings.confirmDialogCancel,
    );

    if(response!.confirmed) {
      this.navigateToProductDetail();
    }
  }

  //------------------------- AUTHENTICATION SERVICE -------------------------
  final AuthenticationDataService _authenticationDataService = locator<AuthenticationDataService>();
  get getAuthenticationDataService => this._authenticationDataService;

  //------------------------- SNACKBAR -------------------------
  final SnackbarService _snackbarService = locator<SnackbarService>();
  void showFinishSnackbar(){
    _snackbarService.showSnackbar(
      message: '',
      title: Strings.snackbarTitle,
      duration: Duration(seconds: 3),
    );
  }

  Future saveOrder(PaymentMethods paymentMethod, double denomination) async {
    Users? results = await Users.getUserByPhoneNumber(this._authenticationDataService.phoneNumber);
    Shipping shipping = new Shipping(this._summaryDataService.getShippingSelected, new GeoPoint(this._summaryDataService.getLocation.latitude, this._summaryDataService.getLocation.longitude), null, paymentMethod.method, denomination);
    Orders order = new Orders(this._authenticationDataService.phoneNumber, results!.name, this._summaryDataService.getSubtotal(), this._summaryDataService.getTotal(), OrderStatus.PENDING.status,double.parse(ConfigurationParameters.getParameter(ConfigurationParameters.sendingPrice),), Timestamp.now(), this._summaryDataService.getProducts(), shipping);
    Orders.saveOrder(order);
  }

}