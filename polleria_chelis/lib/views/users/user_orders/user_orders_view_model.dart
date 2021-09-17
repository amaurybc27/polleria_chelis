
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserOrdersViewModel extends BaseViewModel{

  //------------------------- NAVIGATION SERVICE -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSummaryView() async {
    null;
  }

  //------------------------- DELIVERY SERVICE -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();

  get getDeliveryDataService => _summaryDataService;

  int getProductNumberInCart() {
    return this._summaryDataService.counter;
  }

  //------------------------- DELIVERY SERVICE -------------------------
  final AuthenticationDataService _authenticationDataService = locator<AuthenticationDataService>();
  get getAuthenticationDataService => this._authenticationDataService;

  //------------------------- Dialog SERVICE -------------------------
  final DialogService _dialogService = locator<DialogService>();


  List<Orders> _orders = [];
  List<Orders> get getOrders => _orders;

  Future fetchOrders() async {
    setBusy(true);
    var results = await Orders.getOrdersByUser(_authenticationDataService.phoneNumber);
    setBusy(false);

    if (results is List<Orders>) {
      _orders = results;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Failed on load orders',
        description: "",
      );
    }
  }


}