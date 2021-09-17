
import 'package:flutter/material.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/products.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:polleria_chelis/services/image_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminProductsViewModel extends BaseViewModel{

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

  List<Products> _listProducts = [];
  get getListProducts => this._listProducts;

  Future getProductsForAdmin() async {
    setBusy(true);
    var results = await Products.getProductsForAdmin();
    setBusy(false);

    if (results is List<Products>) {
      _listProducts = results;
      notifyListeners();
    }
  }

  //------------------------- IMAGE SERVICE -------------------------
  final ImageService _imageService = locator<ImageService>();

  Future<Widget> getImage(String image) => _imageService.getImage(image);


  void changeProductStatusValue(Products item, bool value){
    item.status = value;
    notifyListeners();
  }

  void chnageProductPriceValue(Products product, var value){
    product.price = double.parse(value);
    notifyListeners();
  }

  void updateProduct(String id, Products product){
    Products.updateProductStatusAndPriceById(id, product.status, product.price);
    notifyListeners();
  }






}