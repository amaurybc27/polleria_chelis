
import 'package:geocoding/geocoding.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/enum/shipping_methods.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminOrdersDetailViewModel extends BaseViewModel{

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

  Future<String> getAddress(latitude, longitude) async {
    List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = p[0];

    return "${place.street}, ${place.locality} ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
  }

  //ORDER DELIVERY OR IN STORE
  bool isDeliveryOrder(Orders order){
    return order.shipping.shippingMethods == ShippingMethods.DELIVERY ? true : false;
  }

  bool isCancellableOrder(Orders order){
    if(order.status == OrderStatus.PENDING.status || order.status == OrderStatus.ATTENDED.status){
      return true;
    }else{
      return false;
    }
  }


  void launchURL() async {
    const _url = 'https://flutter.dev';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      print('Could not open the map.');
      throw 'Could not open the map.';
    }
  }

  //------------------------- DIALOG -------------------------
  final DialogService _dialogService = locator<DialogService>();
  Future showConfirmCancelledOrderDialog(String id, String status) async {
    DialogResponse? response = await _dialogService.showDialog(
      title: Strings.confirmDialogTitle,
      description: Strings.confirmCancelledOrderDialogDescription,
      buttonTitle: Strings.confirmDialogAcept,
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: Strings.confirmDialogCancel,
    );

    if(response!.confirmed) {
      this.updateOrderStatus(id, status);
    }
  }
  void updateOrderStatus(String id, String status){
    Orders.updateOrderStatus(id, status);
    _navigationService.navigateTo(Routes.adminOrdersView);
  }
}