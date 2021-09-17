

import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/commons/strings.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/products.dart';
import 'package:polleria_chelis/models/order_item.dart';
import 'package:polleria_chelis/models/users.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:polleria_chelis/services/image_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderViewModel extends ReactiveViewModel{

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_summaryDataService];

  //------------------------- SUMMARY SERVICE -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();

  get summaryDataService => _summaryDataService;

  int getProductNumberInCart(){
    return this._summaryDataService.counter;
  }

  Future<void> removeItem(String name) async {
    _summaryDataService.decreaseCounter();
    _summaryDataService.summaryItems.remove(name);

    if(_summaryDataService.summaryItems.isEmpty)
      Future.delayed(Duration(seconds: 2), () async {
        await _navigationService.navigateTo(Routes.productsView);
      });


    notifyListeners();
  }

  void addProduct(Products product){
    OrderItem summaryItem = _summaryDataService.summaryItems[product.name];
    summaryItem.quantity = summaryItem.quantity + 1;

    _summaryDataService.summaryItems[product.name] = summaryItem;
    notifyListeners();
  }

  void minusProduct(Products product){
    OrderItem summaryItem = _summaryDataService.summaryItems[product.name];
    summaryItem.quantity = summaryItem.quantity - 1;

    _summaryDataService.summaryItems[product.name] = summaryItem;
    notifyListeners();
  }


  //------------------------- AUTHENTICATION SERVICE -------------------------
  final AuthenticationDataService _authenticationDataService = locator<AuthenticationDataService>();
  get getAuthenticationDataService => this._authenticationDataService;


  //------------------------- NAVIGATION -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSummaryView() async {
    null;
  }

  Future navigateToShippingView() async {
    bool existUser = await Users.existeUser(this._authenticationDataService.phoneNumber);
    if(existUser){
      await _navigationService.navigateTo(Routes.shippingOrderView);
    } else {
      this.showUpdateUserInfoDialog();
    }
  }

  //------------------------- DIALOG -------------------------
  final DialogService _dialogService = locator<DialogService>();
  Future showUpdateUserInfoDialog() async {
    DialogResponse? response = await _dialogService.showDialog(
      title: Strings.updateUserInfoDialogTitle,
      description: Strings.updateUserInfoDialogDescription,
      buttonTitle: Strings.confirmDialogAcept,
      dialogPlatform: DialogPlatform.Material,
      cancelTitle: Strings.confirmDialogCancel,
    );

    if(response!.confirmed) {
      this.navigateToProfileView();
    }
  }

  Future navigateToProfileView() async {
    await _navigationService.navigateTo(Routes.userProfileView);
  }


  //------------------------- IMAGE SERVICE -------------------------
  final ImageService _imageService = locator<ImageService>();

  Future<Widget> getImage(String image) => _imageService.getImage(image);


}