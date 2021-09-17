
import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/configuration_parameters.dart';
import 'package:polleria_chelis/models/enum/order_status.dart';
import 'package:polleria_chelis/models/enum/shipping_methods.dart';
import 'package:polleria_chelis/models/order_item.dart';
import 'package:polleria_chelis/models/orders.dart';
import 'package:polleria_chelis/models/shipping.dart';
import 'package:polleria_chelis/models/stores.dart';
import 'package:polleria_chelis/models/users.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ShippingOrderViewModel extends ReactiveViewModel {
  final DialogService _dialogService = locator<DialogService>();

  ShippingMethods _shippingSelected = ShippingMethods.DELIVERY;
  get getShippingSelected => _shippingSelected;
  void setShippingSelected(ShippingMethods selected) {
    this._shippingSelected = selected;
    //se reinician los valores del envio
    this._idStore = "";
    this._scheduleSelected = "";
    this._markers = <MarkerId, Marker>{};
    this._addressTextController.text = "";
    notifyListeners();
  }

  String _idStore = "";
  get getIdStore => this._idStore;
  void setIdStore(String newValue) {
    this._idStore = newValue;
    notifyListeners();
  }

  String _scheduleSelected = "";
  get getScheduleSelected => this._scheduleSelected;
  void setScheduleSelected(String newValue) {
    this._scheduleSelected = newValue;
    notifyListeners();
  }

  List<String> get getStoreSchedule {
    List<String> schedule = [];
    this._storesList.forEach((Stores store) {
      if (store.id == this._idStore) {
        schedule = new List<String>.from(store.schedule);
      }
    });

    return schedule;
  }

  bool isEnableButton() {
    bool enable = false;
    if (this._shippingSelected == ShippingMethods.IN_STORE && _scheduleSelected.isNotEmpty && _idStore.isNotEmpty) {
      enable = true;
    } else if (this._shippingSelected == ShippingMethods.DELIVERY && this._addressTextController.text.length > 0) {
      enable = true;
    }
    return enable;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_summaryDataService];

  //------------------------- SUMMARY SERVICE -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();

  get summaryDataService => _summaryDataService;

  int getProductNumberInCart() {
    return this._summaryDataService.counter;
  }

  //------------------------- AUTHENTICATION SERVICE -------------------------
  final AuthenticationDataService _authenticationDataService = locator<AuthenticationDataService>();
  get getAuthenticationDataService => this._authenticationDataService;


  //------------------------- NAVIGATION -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSummaryView() async {
    null;
  }

  Future navigateToPaymentMethodView() async{
    if(this._shippingSelected == ShippingMethods.IN_STORE){
      this._summaryDataService.setShippingSelected(this._shippingSelected);

      await this.saveOrder();
      this.showSnackbar();

      Future.delayed(Duration(seconds: 4), () {
        this._summaryDataService.clearData();
        _navigationService.navigateTo(Routes.productsView);
      });
    }else {
      this._summaryDataService.setShippingSelected(this._shippingSelected);
      this._summaryDataService.setLocation(this._markers.values.elementAt(0).position);

      await _navigationService.navigateTo(Routes.paymentView);
    }
  }


  //------------------------- DIALOG -------------------------
  Future showConfirmDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      title: Strings.confirmDialogTitle,
      description: Strings.confirmDialogDescription,
      buttonTitle: Strings.confirmDialogAcept,
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: Strings.confirmDialogCancel,
    );

    if(response!.confirmed) {
      this.navigateToPaymentMethodView();
    }
  }

  //------------------------- SNACKBAR -------------------------
  final SnackbarService _snackbarService = locator<SnackbarService>();
  void showSnackbar(){
    _snackbarService.showSnackbar(
      message: '',
      title: Strings.snackbarTitle,
      duration: Duration(seconds: 3),
    );
  }

  Future saveOrder() async{
    getStoresList.forEach((Stores s) async {
      if(s.id == this._idStore){
        Users? results = await Users.getUserByPhoneNumber(this._authenticationDataService.phoneNumber);
        Shipping shipping = new Shipping(this._summaryDataService.getShippingSelected, null, new Stores(s.id, s.name, s.address, [this._scheduleSelected]), null, null);
        Orders order = new Orders(this._authenticationDataService.phoneNumber, results!.name, this._summaryDataService.getSubtotal(), this._summaryDataService.getTotal(), OrderStatus.PENDING.status, double.parse(ConfigurationParameters.getParameter(ConfigurationParameters.sendingPrice),), Timestamp.now(), this._summaryDataService.getProducts(), shipping);
        Orders.saveOrder(order);
      }
    });
  }

  //------------------------- STORES -------------------------
  List<Stores> _storesList = [];
  List<Stores> get getStoresList => this._storesList;
  Future fetchStores() async {
    setBusy(true);
    var results = await Stores.getStores();
    setBusy(false);

    if (results is List<Stores>) {
      _storesList = results;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Failed on load stores',
        description: results,
      );
    }
  }



  //------------------------- GOOGLE MAPS -------------------------
  final LatLng _center = const LatLng(19.4978, -99.1269);
  get getCenterLocation => this._center;
  Map<MarkerId, Marker> _markers = new HashMap<MarkerId, Marker>();
  get getMarkers => this._markers;
  late GoogleMapController _controller;
  final _addressTextController = TextEditingController();
  get getAddressTextController => this._addressTextController;

  void onMapCreated(GoogleMapController controller) {
    Completer<GoogleMapController> _mapController = Completer();
    _mapController.complete(controller);

    Future.delayed(Duration(milliseconds: 800), () async {
      GoogleMapController controller = await _mapController.future;

      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
          .then((Position position) {

        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
              LatLng(position.latitude, position.longitude),
              zoom: 17.0,
            ),
          ),
        );

      }).catchError((e) {
        print("Error: " + e.toString());
      });

    });

    this._controller = controller;
  }

  Future addMarkerLongPressed(LatLng latlang) async {
    final MarkerId markerId = MarkerId("RANDOM_ID");
    Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: latlang,
      icon: BitmapDescriptor.defaultMarker,
    );

    _markers[markerId] = marker;

    List<Placemark> p = await placemarkFromCoordinates(latlang.latitude, latlang.longitude);
    Placemark place = p[0];

    getAddressTextController.text = "${place.street}, ${place.locality} ${place.administrativeArea}, ${place.postalCode}, ${place.country}";

    GoogleMapController controller = _controller;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 17.0));
    notifyListeners();
  }

}
