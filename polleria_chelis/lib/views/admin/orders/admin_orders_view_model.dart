
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:polleria_chelis/views/admin/orders_detail/admin_orders_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminOrdersViewModel extends BaseViewModel{

  //------------------------- NAVIGATION SERVICE -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSummaryView() async {
    null;
  }

  Future navigateToAdminOrdersDetail(Orders order) async {
    //await _navigationService.navigateTo(Routes.adminOrdersDetailView);
    await _navigationService.navigateWithTransition(AdminOrdersDetailView(order: order), transition: "fade", duration: Duration(milliseconds: 500), opaque: true, popGesture: true);
  }

  //------------------------- DELIVERY SERVICE -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();

  get getDeliveryDataService => _summaryDataService;

  int getProductNumberInCart() {
    return this._summaryDataService.counter;
  }

  //------------------------- Dialog SERVICE -------------------------
  final DialogService _dialogService = locator<DialogService>();


  //------------------------- ORDERS -------------------------
  List<Orders> _pendingOrders = [];
  List<Orders> get getPendingOrders => _pendingOrders;

  Future getPendingOrdersForAdmin() async {
    setBusy(true);
    var results = await Orders.getOrdersForAdminByStatus(OrderStatus.PENDING.status);
    setBusy(false);

    if (results is List<Orders>) {
      _pendingOrders = results;
      notifyListeners();
    }
  }

  List<Orders> _attendedOrders = [];
  List<Orders> get getAttendedOrders => _attendedOrders;

  Future getAttendedOrdersForAdmin() async {
    setBusy(true);
    var results = await Orders.getOrdersForAdminByStatus(OrderStatus.ATTENDED.status);
    setBusy(false);

    if (results is List<Orders>) {
      _attendedOrders = results;
      notifyListeners();
    }
  }

  List<Orders> _sentOrders = [];
  List<Orders> get getSentOrders => _sentOrders;

  Future getSentOrdersForAdmin() async {
    setBusy(true);
    var results = await Orders.getOrdersForAdminByStatus(OrderStatus.SENT.status);
    setBusy(false);

    if (results is List<Orders>) {
      _sentOrders = results;
      notifyListeners();
    }
  }

  List<Orders> _deliveredOrders = [];
  List<Orders> get getDeliveredOrders => _deliveredOrders;

  Future getDeliveredOrdersForAdmin() async {
    setBusy(true);
    var results = await Orders.getOrdersForAdminByStatus(OrderStatus.DELIVERED.status);
    setBusy(false);

    if (results is List<Orders>) {
      _deliveredOrders = results;
      notifyListeners();
    }
  }

  List<Orders> _cacelledOrders = [];
  List<Orders> get getCancelledOrders => _cacelledOrders;

  Future getCancelledOrdersForAdmin() async {
    setBusy(true);
    var results = await Orders.getOrdersForAdminByStatus(OrderStatus.CANCELLED.status);
    setBusy(false);

    if (results is List<Orders>) {
      _cacelledOrders = results;
      notifyListeners();
    }
  }


}