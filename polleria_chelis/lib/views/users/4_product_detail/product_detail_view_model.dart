
import 'package:flutter/material.dart';
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

class ProductDetailViewModel extends ReactiveViewModel {

  //------------------------- PRODUCT COUNTER -------------------------
  int _productCounter = 0;
  int get productCounter => _productCounter;
  void set productCounter(int newCounter) => _productCounter = newCounter;

  void plusProductCounter(Products product){
    this._productCounter = this._productCounter + 1;
    notifyListeners();
  }

  void minusProductCounter(Products product){
    if(this._productCounter > 0)
      this._productCounter = this._productCounter - 1;
    notifyListeners();
  }



  //------------------------- IMAGE SERVICE -------------------------
  final ImageService _imageService = locator<ImageService>();
  Future<Widget> getImage(String image) => _imageService.getImage(image);

  //------------------------- DATA FOR SUMMARY -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();

  void addProduct(Products product){
    _summaryDataService.summaryItems[product.name] = new OrderItem(quantity: this.productCounter, product: product);
    _summaryDataService.incrementCounter();
    notifyListeners();
  }

  void removeProduct(Products product){
    this.productCounter = 0;
    _summaryDataService.summaryItems.remove(product.name);
    _summaryDataService.decreaseCounter();
    notifyListeners();
  }

  int getSummaryItemsQuantity(Products product){
    if(_summaryDataService.summaryItems.containsKey(product.name)){
      return _summaryDataService.summaryItems[product.name].quantity;
    }
    return 0;
  }

  bool existInSummaryItems(Products product){
    if(_summaryDataService.summaryItems.containsKey(product.name)){
      return true;
    }
    return false;
  }

  int getProductNumberInCart(){
    return this._summaryDataService.counter;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_summaryDataService];

  //------------------------- NAVIGATION -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSummaryView() async {
    await _navigationService.navigateTo(Routes.orderView);
  }

}