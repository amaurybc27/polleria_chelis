
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:polleria_chelis/app/setup/app_setup.router.dart';
import 'package:polleria_chelis/app/setup/locator.dart';
import 'package:polleria_chelis/models/categories.dart';
import 'package:polleria_chelis/models/products.dart';
import 'package:polleria_chelis/services/authentication_data_service.dart';
import 'package:polleria_chelis/services/delivery_data_service.dart';
import 'package:polleria_chelis/services/image_service.dart';
import 'package:polleria_chelis/views/users/4_product_detail/product_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductsViewModel extends ReactiveViewModel {
  final DialogService _dialogService = locator<DialogService>();


  //------------------------- CATEGORIES -------------------------
  List<Categories> _categories = [];
  List<Categories> get categories => _categories;

  Future fetchCategories() async {
    setBusy(true);
    var results = await Categories.getCategories();
    setBusy(false);

    if (results is List<Categories>) {
      _categories = results;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Failed on load categories',
        description: results,
      );
    }
  }





  //------------------------- PRODUCTS -------------------------

  Map<String, List<Products>> _mapProducts =
  new HashMap<String, List<Products>>();

  get mapProducts => _mapProducts;

  Future fetchProducts() async {
    setBusy(true);
    var results = await Products.getMapProducts();
    setBusy(false);

    if (results is HashMap<String, List<Products>>) {
      _mapProducts = results;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Failed on load products',
        description: results,
      );

    }
  }

  //------------------------- NAVIGATION -------------------------
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToLogin() async {
    await _navigationService.navigateTo(Routes.onboardingView);
  }

  Future navigateToSummaryView() async {
    await _navigationService.navigateTo(Routes.orderView);
  }

  Future navigateToProfileView() async {
    await _navigationService.navigateTo(Routes.userProfileView);
  }

  Future navigateToOrdersView() async {
    await _navigationService.navigateTo(Routes.userOrdersView);
  }

  navigateToProductDetail(Products product) async {
    await _navigationService.navigateWithTransition(ProductDetailView(product: product), transition: "fade", duration: Duration(milliseconds: 500), opaque: true, popGesture: true);
  }

  Future navigateToAdminOrders() async {
    await _navigationService.navigateTo(Routes.adminOrdersView);
  }

  Future navigateToAdminProducts() async {
    await _navigationService.navigateTo(Routes.adminProductsView);
  }



  Future singout() async {
    print("singout");
    await FirebaseAuth.instance.signOut();

    User? u = FirebaseAuth.instance.currentUser;

    if(u == null){
      this.navigateToLogin();
    }else{
      print("No se pudo cerrar cesion");
    }
  }

  //------------------------- ICON FAVORITE -------------------------
  bool _favorite = false;

  get favorite => _favorite;

  void changeFavorite() {
    if (_favorite)
      _favorite = false;
    else
      _favorite = true;

    notifyListeners();
  }

  //------------------------- IMAGE SERVICE -------------------------
  final ImageService _imageService = locator<ImageService>();

  Future<Widget> getImage(String image) => _imageService.getImage(image);

  //------------------------- SUMMARY SERVICE -------------------------
  final DeliveryDataService _summaryDataService = locator<DeliveryDataService>();

  get summaryDataService => _summaryDataService;

  int getProductNumberInCart(){
    //return this._summaryDataService.summaryItems.length;
    return this._summaryDataService.counter;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_summaryDataService];

  //------------------------- AUTHENTICATION DATA SERVICE -------------------------
  final AuthenticationDataService _authenticationDataService = locator<AuthenticationDataService>();
  get getAuthenticationDataService => this._authenticationDataService;

}
